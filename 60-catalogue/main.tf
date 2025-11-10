resource "aws_instance" "catalogue" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
       # roboshop-dev-catalogue"
    }
  )
}
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  connection {
    type       = "ssh"
      user     = "ec2-user"
      password = "DevOps321" #// Use with caution, consider private_key for SSH
      host     = aws_instance.catalogue.private_ip # // Or self.private_ip depending on network
      port     = 22
  }

  provisioner "file" {
      source      = "catalogue.sh" # Path to your local file
      destination = "/tmp/catalogue.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
     ]
    
  }
}
resource "aws_ec2_instance_state" "stop_my_instance" {
    instance_id = aws_instance.catalogue.id
    state       = "stopped"
    depends_on = [ terraform_data.catalogue ]
}

resource "aws_ami_from_instance" "catalogue_ami" {
  name          = "roboshop-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  description   = "AMI created for ASG template"
  depends_on = [ aws_ec2_instance_state.stop_my_instance ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-ami"
    }
  )
  
}
resource "aws_lb_target_group" "catalogue" {
  name        = "${local.common_name_prefix}-catalogue"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  deregistration_delay = 60
  health_check {
    healthy_threshold = 2
    interval = 10
    matcher = 200-299
    path = "/health"
    port = 80
    timeout = 2
    unhealthy_threshold = 2
    protocol = "HTTP"
  }
}
resource "aws_launch_template" "catalogue" {
  name = "${local.common_name_prefix}-catalogue"
  image_id = local.ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpc_id]
  update_default_version = true # gets latest ami id available

  placement {
    availability_zone = "us-east-1a"
  }
 # Tags for instance created through asg
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-catalogue"
      }
    )
  }
 # tags for volumes created by ec2 instances
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-catalogue"
      }
    )
  }
  tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-catalogue"
      }
    )
}


resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name_prefix}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = false
  vpc_zone_identifier       = [local.private_subnet_ids_1a, local.private_subnet_ids_1b]
  target_group_arns         = [aws_lb_target_group.catalogue.arn]

  launch_template {
    id = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version 
     }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }

  dynamic tag {
    for_each = merge( #using map to loop key and values
      local.common_tags,
      {
        Name = "${local.common_name_prefix}-catalogue"
      }
    )
    content {
      key                 = tag.key
     value               = tag.value
     propagate_at_launch = true
   }
  }

  timeouts {
    delete = "15m"
  }
}


resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = local.backend_alb_listener
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }

  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.environment}.${var.domain_name}"]
    }
  }
}

resource "aws_autoscaling_policy" "catalogue-asg-policy" {
  name                   = "${local.common_name_prefix}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0 # Target average CPU utilization of 50%
  }
}

resource "terraform_data" "Terminating_catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  depends_on = [
    aws_autoscaling_policy.catalogue-asg-policy
  ]

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }
}
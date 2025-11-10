# backend internal alb
resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_prefix}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = false

  tags = merge(
      local.common_tags,
      {
        Name = "backend-alb"
      }
    )   
}
# lsitener to backendalb using 80 port
resource "aws_lb_listener" "backend_alb_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is back back back !!!!"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb_record" {
      zone_id = var.zone_id
      name    = "*.backend-alb-${var.environment}.${var.domain_name}" # Or your desired subdomain
      type    = "A"

      alias {
        name                   = aws_lb.backend_alb.dns_name
        zone_id                = aws_lb.backend_alb.zone_id
        evaluate_target_health = true # Recommended for ALBs
      }
      allow_overwrite = true
}
    

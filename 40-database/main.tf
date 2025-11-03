######### mongodb ########
resource "aws_instance" "mongodb" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mongodb"
       # roboshop-dev-mongodb"
    }
  )
}
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
connection {
  type       = "ssh"
    user     = "ec2-user"
    password = "DevOps321" #// Use with caution, consider private_key for SSH
    host     = aws_instance.mongodb.private_ip # // Or self.private_ip depending on network
    port     = 22
}

 provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/opt/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /opt/bootstrap.sh",
      "sudo sh /opt/bootstrap.sh mongodb dev"
     ]
    
  }
}

##### redis database #######
resource "aws_instance" "redis" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-redis"
    }
  )
}
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
connection {
  type       = "ssh"
    user     = "ec2-user"
    password = "DevOps321" #// Use with caution, consider private_key for SSH
    host     = aws_instance.redis.private_ip  #// Or self.private_ip depending on network
    port     = 22

}
provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/opt/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /opt/bootstrap.sh",
      "sudo sh /opt/bootstrap.sh redis dev"
     ]
    
  }
}
###### rabbitmq ######
resource "aws_instance" "rabbitmq" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
connection {
  type       = "ssh"
    user     = "ec2-user"
    password = "DevOps321" #// Use with caution, consider private_key for SSH
    host     = aws_instance.rabbitmq.private_ip # // Or self.private_ip depending on network
    port     = 22

}
provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/opt/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /opt/bootstrap.sh",
      "sudo sh /opt/bootstrap.sh rabbitmq dev"
     ]
    
 }
}

######### mysql #########
resource "aws_iam_instance_profile" "mysql" {
  name = "mysql"
  role = "aws_ec2_ssmaccess_mysql"
}
resource "aws_instance" "mysql" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id = local.database_subnet_ids
  iam_instance_profile = aws_iam_instance_profile.mysql.name
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mysql"
    }
  )
}
resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]
connection {
  type       = "ssh"
    user     = "ec2-user"
    password = "DevOps321" #// Use with caution, consider private_key for SSH
    host     = aws_instance.mysql.private_ip  #// Or self.private_ip depending on network
    port     = 22
}

 provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/opt/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /opt/bootstrap.sh",
      "sudo sh /opt/bootstrap.sh mysql dev"
     ]
    
  }
}

################################################# R53 ############################################################

resource "aws_route53_record" "mongodb" {
  zone_id = "Z0212707MY585LOOEFGA"
  name    = "mongodb-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
}

resource "aws_route53_record" "redis" {
  zone_id = "Z0212707MY585LOOEFGA"
  name    = "redis-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
}
resource "aws_route53_record" "rabbitmq" {
  zone_id = "Z0212707MY585LOOEFGA"
  name    = "rabbitmq-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
}
resource "aws_route53_record" "mysql" {
  zone_id = local.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
}
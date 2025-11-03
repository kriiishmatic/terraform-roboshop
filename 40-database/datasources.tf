data "aws_ami" "ami_id" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project}/${var.environment}/mongodb_sg_ids"
}
data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${var.project}/${var.environment}/redis_sg_ids"
}
data "aws_ssm_parameter" "rabbitmq_sg_id" {
  name = "/${var.project}/${var.environment}/rabbitmq_sg_ids"
}

data "aws_ssm_parameter" "database_subnet_ids" {
    name = "${local.common_name_prefix}-database-subnets" 
}

data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${var.project}/${var.environment}/mysql_sg_ids"
}

# data from aws-zone
data "aws_route53_zone" "zone_id" {
  name         = "${var.domain_name}." # Replace with your Hosted Zone name
  private_zone = true          # Set to true for private hosted zones
}
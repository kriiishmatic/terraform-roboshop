data "aws_ami" "ami-data" {
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

data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project}/${var.environment}/bastion_sg_ids"
}

data "aws_ssm_parameter" "public-subnet-id" {
  name = "${local.common_name_prefix}-public-subnets"
}

# data "aws_ssm_parameter" "pub-sub" {
#   name = "${local.common_name_prefix}-public-subnet-${count.index + 1}"
# }
locals {
  common_name_prefix = "${var.project}-${var.environment}"
  common_tags = {
    project     = var.project
    environment = var.environment
    terraform   = true
  }
  vpc_id = data.aws_ssm_parameter.vpc_id.value
#   public_subnets = data.aws_ssm_parameter.public_subnet_ids.value
}
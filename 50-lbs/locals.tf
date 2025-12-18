locals {
  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
  frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
  common_name_prefix = "${var.project}-${var.environment}"
  private_subnet_ids = split(",",data.aws_ssm_parameter.private_subnet_ids.value)
  public_subnet_ids = split(",",data.aws_ssm_parameter.public_subnet_ids.value)
  common_tags = {
    "project" = var.project
    "environment" = var.environment
  }

}
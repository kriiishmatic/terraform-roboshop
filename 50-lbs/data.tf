data "aws_ssm_parameter" "backend_alb_sg_id" {
  name = "/${var.project}/${var.environment}/backend_alb_sg_ids"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "${local.common_name_prefix}-private-subnets"
}
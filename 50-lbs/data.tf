data "aws_ssm_parameter" "backend_alb_sg_id" {
  name = "/${var.project}/${var.environment}/backend_alb_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "${local.common_name_prefix}-private-subnets"
}

data "aws_ssm_parameter" "frontend_alb_sg_id" {
  name = "/${var.project}/${var.environment}/frontend_alb_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "${local.common_name_prefix}-public-subnets"
}

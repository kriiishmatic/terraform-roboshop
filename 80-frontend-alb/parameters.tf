resource "aws_ssm_parameter" "frontend_alb_arn" {
  name  = "${local.common_name_prefix}_frontend_alb_arn" #roboshop-dev_frontend_alb-arn
  type  = "String"
  value = aws_lb.frontend_alb.arn
}
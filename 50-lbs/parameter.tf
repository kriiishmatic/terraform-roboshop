resource "aws_ssm_parameter" "backend_alb_listener" {
  name        = "${local.common_name_prefix}_backend_alb_listener"
  type        = "String"
  value       = aws_lb_listener.backend_alb_listener.arn
  description = "ARN of the main application load balancer lsiteneer"
}
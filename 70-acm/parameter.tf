resource "aws_ssm_parameter" "acm_certificate_arn" {
      name        = "/${var.project}/${var.environment}/acm"
      type        = "String"
      value       = aws_acm_certificate.roboshop.arn # Reference to an existing ACM certificate ARN
      description = "ARN of the ACM certificate for my application"
      tags = merge(
        local.common_tags,
        {
          Name = "${local.common_name_prefix}-arn"
        })
    }
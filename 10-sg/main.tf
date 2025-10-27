module "catalogue" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.common_name_prefix}-catalogue"
  use_name_prefix = false
  description = "Security group for catalogue with custom ports open within VPC"
  vpc_id      = data.aws_ssm_parameter.data-ssm.value
}


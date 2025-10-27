data "aws_ssm_parameter" "data-ssm" {
  name = "${local.common_name_prefix}-vpc_id"
}
data "aws_ssm_parameter" "public_subnets" {
  name ="${local.common_name_prefix}-public_subnets"
}
data "aws_ssm_parameter" "vpc_id" {
  name = "${local.common_name_prefix}-vpc_id"
}
# data "aws_ssm_parameter" "public-subnets" {
#   name ="${local.common_name_prefix}-public-subnets"
# }
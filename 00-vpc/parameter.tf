resource "aws_ssm_parameter" "vpc_id" {
  name  = "local.common_name_prefix-vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public-subnets" {
  name = "${local.common_name_prefix}-public-subnets"
  type = "StringList"
  value = join(",", module.vpc.public_subnets)
}
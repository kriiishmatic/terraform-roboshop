resource "aws_ssm_parameter" "vpc_id" {
  name  = "local.common_name_prefix-vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}
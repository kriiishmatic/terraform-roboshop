data "aws_ssm_parameter" "data-ssm" {
  name = "local.common_name_prefix-vpc_id"
}
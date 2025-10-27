# community modules ###########
# module "catalogue" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "${local.common_name_prefix}-catalogue"
#   use_name_prefix = false
#   description = "Security group for catalogue with custom ports open within VPC"
#   vpc_id      = data.aws_ssm_parameter.data-ssm.value
# }

module "sg-roboshop" {
    source = "git::https://github.com/kriiishmatic/terraform-roboshop-sgs.git/ref=main"
  count = length (var.sg_name)
  sg_name = var.sg_name[count.index]
  vpc_id = local.vpc_id
  description = var.description

}

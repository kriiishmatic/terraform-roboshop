# community modules ###########
# module "catalogue" {
#   source = "terraform-aws-modules/security-group/aws"

#   name        = "${local.common_name_prefix}-catalogue"
#   use_name_prefix = false
#   description = "Security group for catalogue with custom ports open within VPC"
#   vpc_id      = data.aws_ssm_parameter.data-ssm.value
# }

module "sg-roboshop" {
    source = "git::https://github.com/kriiishmatic/terraform-roboshop-sgs.git?ref=main"
  count = length (var.sg_name)
  sg_name = "${var.project}-${var.environment}-${var.sg_name[count.index]}"
  vpc_id = local.vpc_id
  sg_description = "created for ${var.sg_name[count.index]}"
  sg_tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-${var.sg_name[count.index]}",

    }
  )
}
# frontend to frontendlb
resource "aws_security_group_rule" "frontend_frontendlb" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = module.sg-roboshop[9].sg_id
  source_security_group_id = module.sg-roboshop[11].sg_id
  description = "frontend to frontendlb"
}

  

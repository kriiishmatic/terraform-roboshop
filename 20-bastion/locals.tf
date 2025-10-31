locals {
  common_name_prefix = "${var.project}-${var.environment}"
  common_tags = {
    project     = var.project
    environment = var.environment
  }
  ami-id = data.aws_ami.ami-data.id
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  public_subnet_ids = split("," , data.aws_ssm_parameter.public-subnet-id.value)[0]

}
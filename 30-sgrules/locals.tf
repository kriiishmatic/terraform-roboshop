locals {
  common_name_prefix = "${var.project}-${var.environment}"
  common_tags = {
    project     = var.project
    environment = var.environment
    terraform   = true
  }
  bastion_sg_id = data.aws_ssm_parameter.bastion_id.value
  backend_alb_id = data.aws_ssm_parameter.backend_alb_sg_ids.value
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
}
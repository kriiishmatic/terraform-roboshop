locals {
    ami-id = data.aws_ami.ami-data.value
  common_tags = {
    project = var.project
    envinronment = var.environment
    terraform = true
    purpose = "database-created-roboshop"
}
  common_name_prefix = "${var.project}-${var.environment}"
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
  database_subnet_ids = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
}   
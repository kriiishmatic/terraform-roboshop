#aws resource for secuiry groups rule ingress
resource "aws_security_group_rule" "bastion_backend_alb" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = local.backend_alb_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to backend alb"
}

resource "aws_security_group_rule" "from-anywhere-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Allow from anywhere
  security_group_id = local.bastion_sg_id
  description       = "Allow HTTP access from internet"
}


resource "aws_security_group_rule" "bastion_redis" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to redis"
}


resource "aws_security_group_rule" "bastion_rabbitmq" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.rabbitmq_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to rabbitmq"
}

resource "aws_security_group_rule" "bastion_mongodb" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to mongodb"
}

resource "aws_security_group_rule" "bastion_mysql" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to mongodb"
}

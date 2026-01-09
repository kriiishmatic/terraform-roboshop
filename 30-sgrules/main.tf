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
  description = "bastion to mysql"
}

resource "aws_security_group_rule" "bastion_catalogue" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.catalogue_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to catalogue"
}

resource "aws_security_group_rule" "catalogue_mongodb" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.catalogue_sg_id
  description = "catalogue to mongodb"
}

resource "aws_security_group_rule" "backend_alb_catalogue" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  security_group_id = local.catalogue_sg_id
  source_security_group_id = local.backend_alb_id
  description = "bastion to catalogue"
}

# load balancer accepting traffic from internet
resource "aws_security_group_rule" "internet-frontend-alb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Allow from anywhere
  security_group_id = local.frontend_alb_sg_id
  description       = "Allow HTTP access from internet"
}

resource "aws_security_group_rule" "bastion_user" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.user_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to user"
}

resource "aws_security_group_rule" "bastion_shipping" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.shipping_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to shipping"
}

resource "aws_security_group_rule" "bastion_payment" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.payment_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to payment"
}

resource "aws_security_group_rule" "bastion_cart" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  security_group_id = local.cart_sg_id
  source_security_group_id = local.bastion_sg_id
  description = "bastion to cart"
}

######connection between components#######
resource "aws_security_group_rule" "catalogue_mongodb" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.catalogue_sg_id
  description = "catalogue to mongodb"
}

resource "aws_security_group_rule" "catalogue_redis" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.catalogue_sg_id
  description = "catalogue to redis"
}

resource "aws_security_group_rule" "user_redis" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.user_sg_id
  description = "user to redis"
}

resource "aws_security_group_rule" "cart_redis" {
  type = "ingress"
  from_port = 6379
  to_port = 6379
  protocol = "tcp"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.cart_sg_id
  description = "cart to redis"
}

resource "aws_security_group_rule" "shipping_mysql" {
  type = "ingress"
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.shipping_sg_id
  description = "shipping to mysql"
}

resource "aws_security_group_rule" "payment_rabbitmq" {
  type = "ingress"
  from_port = 5672
  to_port = 5672
  protocol = "tcp"
  security_group_id = local.rabbitmq_sg_id
  source_security_group_id = local.payment_sg_id
  description = "payment to rabbitmq"
}
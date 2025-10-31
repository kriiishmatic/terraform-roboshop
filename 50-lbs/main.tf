# backend internal alb
resource "aws_lb" "backend_alb" {
  name               = "test-lb-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  enable_deletion_protection = false

  tags = merge(
      local.common_tags,
      {
        Name = "backend-alb"
      }
    )   
}
# lsitener to backendalb using 80 port
resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "This is back back back !!!!"
      status_code  = "200"
    }
  }
}
  

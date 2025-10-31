#resource aws instance
resource "aws_instance" "bastion" {
  ami = local.ami-id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "bastion-for-test"
    }
  )
}
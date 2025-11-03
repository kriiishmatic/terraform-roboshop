#resource aws instance
resource "aws_instance" "bastion" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_ids
  user_data =file("terraform-i.sh")
  iam_instance_profile = aws_iam_instance_profile.bastion.name ### dont have to configure aws on bastion again since now it has admin access
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-bastion"
    }
  )
}

 resource "aws_iam_instance_profile" "bastion" {
      name = "${var.project}-${var.environment}-bastion"
      role = "Bastionterraformadminaccess"
 }
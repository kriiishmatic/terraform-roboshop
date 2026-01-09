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
resource "aws_iam_role" "bastion_role" {
  name = "Bastionterraformadminaccess"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}
resource "aws_iam_role_policy_attachment" "bastion_admin" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  depends_on = [ aws_iam_role.bastion_role] 
}

resource "aws_iam_instance_profile" "bastion" {
  name = "roboshop-dev-bastion"
  role = aws_iam_role.bastion_role.name
  depends_on = [ aws_iam_role_policy_attachment.bastion_admin ]
}

#  resource "aws_iam_instance_profile" "bastion" {
#       name = "${var.project}-${var.environment}-bastion"
#       role = "Bastionterraformadminaccess"
#  }
resource "aws_instance" "catalogue" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  subnet_id = local.private_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
       # roboshop-dev-catalogue"
    }
  )
}
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
connection {
  type       = "ssh"
    user     = "ec2-user"
    password = "DevOps321" #// Use with caution, consider private_key for SSH
    host     = aws_instance.catalogue.private_ip # // Or self.private_ip depending on network
    port     = 22
}

 provisioner "file" {
    source      = "catalogue.sh" # Path to your local file
    destination = "/tmp/catalogue.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/catalogue.sh",
      "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
     ]
    
  }
}
resource "aws_ec2_instance_state" "stop_my_instance" {
    instance_id = aws_instance.catalogue.id
    state       = "stopped"
    depends_on = [ terraform_data.catalogue ]
}
resource "aws_ami_from_instance" "catalogue_ami" {
  name          = "roboshop-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  description   = "AMI created for ASG template"
  depends_on = [ aws_ec2_instance_state.stop_my_instance ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-ami"
    }
  )
  
}
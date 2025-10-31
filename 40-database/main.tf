######### mongodb ######
resource "aws_instance" "mongodb" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mongodb # roboshop-dev-mongodb"
    }
  )
}
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
connection {
  type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321" // Use with caution, consider private_key for SSH
    host     = aws_instance.mongodb.private_ip  // Or self.private_ip depending on network
    port     = 22
}

 provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/tmp/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstarp.sh",
      "sudo sh /tmp/bootstrap.sh mongodb"
     ]
    
  }
}

##### redis database #####
resource "aws_instance" "redis" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-redis# roboshop-dev-mongodb"
    }
  )
}
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
connection {
  type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321" // Use with caution, consider private_key for SSH
    host     = aws_instance.redis.private_ip  // Or self.private_ip depending on network
    port     = 22

}
provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/tmp/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstarp.sh",
      "sudo sh /tmp/bootstrap.sh redis"
     ]
    
  }
}
###### rabbitmq ######
resource "aws_instance" "rabbitmq" {
  ami = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq # roboshop-dev-rabbitmq"
    }
  )
}
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
connection {
  type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321" // Use with caution, consider private_key for SSH
    host     = aws_instance.rabbitmq.private_ip  // Or self.private_ip depending on network
    port     = 22

}
provisioner "file" {
    source      = "bootstrap.sh" # Path to your local file
    destination = "/tmp/bootstrap.sh"
}
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstarp.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq"
     ]
    
}
}


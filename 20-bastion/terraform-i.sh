#!/bin/bash

growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

## creating databases
cd home/ec2-user
git clone https://github.com/kriiishmatic/terraform-roboshop.git
chown -R ec2-user:ec2-user terraform-roboshop
cd terraform-roboshop/40-database
terraform init
terraform apply -auto-approve

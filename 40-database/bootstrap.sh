#!/bin/bash
component = $1
sudo su 
dnf install ansible -y
ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e component=$component main.yaml
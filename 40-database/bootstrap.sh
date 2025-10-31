#!/bin/bash

component = mongodb
dnf install ansible -y
ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e component=mongodb main.yaml
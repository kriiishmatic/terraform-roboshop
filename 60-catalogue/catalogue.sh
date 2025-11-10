# #!/bin/bash

# component = $1
# dnf install ansible -y
# ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e component=$component main.yaml

component=$1
environment=$2
dnf install -y ansible
# ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e "component=${component}" main.yaml

repo_url=https://github.com/kriiishmatic/Roles-Ansible-terraform.git
repo_dir=/opt/ansible/
ansible_dir=Roles-Ansible-terraform

mkdir -p /opt/ansible/
mkdir -p /var/log/dynamic/
touch ansible.log
cd $repo_dir

if [ ! -d $ansible_dir ]; then
  git clone $repo_url
  cd $ansible_dir
  else
  cd $ansible_dir
  git pull
fi

ansible-playbook -i inventory.ini -e "component=${component}" -e "env=${environment}" main.yaml 
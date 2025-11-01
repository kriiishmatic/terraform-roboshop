# #!/bin/bash

# component = $1
# dnf install ansible -y
# ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e component=$component main.yaml

component=$1
environment=$2
dnf install -y ansible
# ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e "component=${component}" main.yaml

repo_url=https://github.com/kriiishmatic/terraform-robo-ansibleroles.git
repo_dir=/opt/ansible/
ansible_dir=terraform-robo-ansibleroles

mkdir -p /opt/ansible/

if [ ! -d $repo_dir$ansible_dir ]; then
  cd $repo_dir
  git clone $repo_url
  else
  cd $repo_dir$ansible_dir
  git pull
fi

ansible-playbook -i inventory.ini -e "component=${component}" -e "env=${environment}" main.yaml}
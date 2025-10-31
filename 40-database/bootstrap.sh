# #!/bin/bash

# component = $1
# dnf install ansible -y
# ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e component=$component main.yaml


#!/bin/bash

component=$1
dnf install -y ansible
ansible-pull -U https://github.com/kriiishmatic/terraform-robo-ansibleroles.git -e "component=${component}" main.yaml


module "main" {
  source = "../terraform-roboshop-component"
  
}

module "main" {
  for_each = var.component
  source = "git::https://github.com/kriiishmatic/Roles-Ansible-terraform.git?ref=main"
  component = each.key
  environment = var.environment
  rule_priority = each.value.rule_priority
}

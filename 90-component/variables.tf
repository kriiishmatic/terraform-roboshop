variable "component" {
  description = "Component name"
  type        = map()
  default = {
    catalogue ={ rule_priority = 10 }
    cart ={ rule_priority = 20 }
    user ={ rule_priority = 30 }
    shipping ={ rule_priority = 40 }
    payment ={ rule_priority = 50 }
    frontend ={ rule_priority = 10}
  }
}

variable "project" {
  default = "roboshop"
}

variable "envinronment" {
    default = "dev"
}

variable "rule_priority" {
  type = number
  default = 10
}

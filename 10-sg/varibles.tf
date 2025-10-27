variable "project" {
  type = string
  default = "roboshop"
}
variable "environment" {
  type = string
  default = "dev"
}

variable "subnet_id" {
  
}

variable "sg_name" {
  type = list
  default = [#databse
    "mysql","mongod","redis","rabbitmq",
    #backend
    "catalogue","cart","user","shipping","payment",
    #frontend
    "frontend",
    #bastion
    "bastion",
    #frontend-lb
    "frontend-lb"
  
  ]
}

variable "description" {
  default = "sg for all components"
}
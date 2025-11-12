variable "project" {
  type = string
  default = "roboshop"
}
variable "environment" {
  type = string
  default = "dev"
}

variable "sg_name" {
  type = list
  default = [#databse
    "mysql","mongodb","redis","rabbitmq",
    #backend
    "catalogue","cart","user","shipping","payment",
    #frontend
    "frontend",
    #bastion
    "bastion",
    #frontend-lb
    "frontend_alb",
    #backed_alb
    "backend_alb",
    #frontend_alb
    "frontend_alb"

  ]
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_tags" {
  type = map
  default = {
    "Name" = "vpc-test"
    "Environment" = "test"
  }
}

variable "igw_tags" {
  type = map
  default = {
    "Name" = "igw-test"
    "Environment" = "test"
  }
}

variable "project_name" {
  type = string
  default = "roboshop"
}

variable "environment" {
  type = string
    default = "dev"
}

variable "vpc-public-subnet-cidr" {
  description = "public subnet cidr 1a"
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc-private-subnet-cidr" {
  description = "private subnet cidr"
  type = list
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "vpc-database-subnet-cidr" {
  description = "database subnet cidr "
  type = list
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "public_subnet_tags" {
  description = "Only useful tags"
  default = {
    "Name" = "public-subnet-test"
    "Environment" = "test"
  }
}

variable "private_subnet_tags" {
  description = "Only useful tags"
    default = {
        "Name" = "private-subnet-test"
        "Environment" = "test"
    }
}

variable "database_subnet_tags" {
  description = "Only useful tags"
    default = {
        "Name" = "database-subnet-test"
        "Environment" = "test"
    }
}

variable "eip_tags" {
  type = map
    default = {}
}



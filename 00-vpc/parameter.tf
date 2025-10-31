resource "aws_ssm_parameter" "vpc_id" {
  name  = "${local.common_name_prefix}-vpc_id" #roboshop-dev-vpc_id
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public-subnets" {
  name = "${local.common_name_prefix}-public-subnets"
  type = "StringList"
  value = join(",", module.vpc.public_subnet_ids) # ["sg-123","sh-324"] --> sg-123,sg-324
}

resource "aws_ssm_parameter" "private-subnets" {
  name = "${local.common_name_prefix}-private-subnets"
  type = "StringList"
  value = join(",", module.vpc.private_subnet_ids) # ["sg-123","sh-324"] --> sg-123,sg-324
}

resource "aws_ssm_parameter" "database-subnets" {
  name = "${local.common_name_prefix}-database-subnets"
  type = "StringList"
  value = join(",", module.vpc.database_subnet_ids) # ["sg-123","sh-324"] --> sg-123,sg-324
}

# resource "aws_ssm_parameter" "public-subnets" {
#   count = length(var.vpc-public-subnet-cidr)

#   name  = "${local.common_name_prefix}-public-subnet-${count.index + 1}" # loop and create individual pub-sub ids
#   type  = "String"
#   value = module.vpc.public_subnet_ids[count.index]
# }

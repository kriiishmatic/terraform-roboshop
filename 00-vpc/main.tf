module "vpc" {
    source = "git::https://github.com/kriiishmatic/terraform-vpc-module.git"
    #VPC
    vpc_cidr_block = var.vpc_cidr_block
    vpc_tags = var.vpc_tags
    project_name = var.project_name
    environment = var.environment
    #IG
    igw_tags = var.igw_tags

    #Subnets pulic
    vpc-public-subnet-cidr = var.vpc-public-subnet-cidr
    public_subnet_tags = var.public_subnet_tags

    #Subnets private
    vpc-private-subnet-cidr = var.vpc-private-subnet-cidr
    private_subnet_tags = var.private_subnet_tags

    #Subnets databas
    vpc-database-subnet-cidr = var.vpc-database-subnet-cidr
    database_subnet_tags = var.database_subnet_tags

}

#Config AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

# Create VPS
# resource "aws_vpc" "App_VPC"
#   cidr_block = "10.0.0.0/16"
#
#
#   tags = {
#     Name = "Eng54_VS_App_VPC"
#   }
# }



data "aws_internet_gateway" "default-gw" {

  filter {
    name = "attachment.vpc-id"
    values = [var.vpc_id]

  }

}

module "app" {
  source = "./modules/app_tier"
  vpc_id = var.vpc_id
  ami_id = var.ami_id
  name = var.name
  igtw = data.aws_internet_gateway.default-gw.id
}








# NACL
# Security Group

# Create Internet Gateway

# Call Module

# Call Module

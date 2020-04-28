#Config AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

#Create VPC
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.name}-VPC"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "${var.name}-ig"
  }
}
# data "aws_internet_gateway" "default-gw" {
#
#   filter {
#     name = "attachment.vpc-id"
#     values = [var.vpc_id]
#
#   }
#
# }

module "app" {
  source = "./modules/app_tier"
  vpc_id = aws_vpc.app_vpc.id
  ami_id = var.ami_id
  name = var.name
  igw = aws_internet_gateway.igw.id
  # pub_ip = module.db.pub_ip
  # db_instance-ip = module.db.db_instance-ip
  # igtw = data.aws_internet_gateway.default-gw.id
}

module "db" {
  source = "./modules/db_tier"
  vpc_id = aws_vpc.app_vpc.id
  name = var.name
  db_ami_id = var.db_ami_id


}





# NACL
# Security Group

# Create Internet Gateway

# Call Module

# Call Module

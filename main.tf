#Config AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

# Create VPS
# resource "aws_vpc" "App_VPC" {
#   cidr_block = "10.0.0.0/16"
#
#
#   tags = {
#     Name = "Eng54_VS_App_VPC"
#   }
# }

# Launching and Instance
# ami-054778af2ffd719dd

resource "aws_instance" "app_instance" {
    ami = "ami-040bb941f8d94b312"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    tags = {
      Name = "Eng54-Victor-App"
    }
  }


# Create Internet Gateway

# Call Module

# Call Module

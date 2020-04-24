#Config AWS Provider
provider "aws" {
  region  = "eu-west-1"
}

# Create VPS
resource "aws_vpc" "App_VPC" {
  cidr_block = "10.0.0.0/16"


  tags = {
    Name = "Eng54_VS_App_VPC"
  }
}




# Create Internet Gateway

# Call Module

# Call Module

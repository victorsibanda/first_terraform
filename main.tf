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


resource "aws_subnet" "app_subnet" {
  vpc_id     = "vpc-07e47e9d90d2076da"
  cidr_block = "172.31.83.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "Victor_app_subnet"
  }
}

resource "aws_security_group" "Victor_App_SG" {
  name        = "app-sg-victor-name"
  description = "Allows for traffic on Port 80"
  vpc_id      = "vpc-07e47e9d90d2076da"

  ingress {
    description = "Port 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Victor_App_SG"
  }
}


# Launching and Instance
# ami-054778af2ffd719dd

resource "aws_instance" "app_instance" {
    ami = "ami-040bb941f8d94b312"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.app_subnet.id
    security_groups = [aws_security_group.Victor_App_SG.id]
    tags = {
      Name = "Eng54-Victor-App"
    }
  }

# Route Table
# NACL
# Security Group

# Create Internet Gateway

# Call Module

# Call Module

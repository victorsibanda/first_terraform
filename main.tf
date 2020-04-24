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
  vpc_id     = var.vpc_id
  cidr_block = "172.31.83.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "Victor_app_subnet"
  }
}

data "aws_internet_gateway" "default-gw" {

  filter {
    name = "attachment.vpc-id"
    values = [var.vpc_id]

  }

}

# Route Table
resource "aws_route_table" "public" {

vpc_id = var.vpc_id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default-gw.id
  }
  tags = {
    Name = "Route-Table-VS-public"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.public.id
}



resource "aws_security_group" "App_SG" {
  name        = "App-SG"
  description = "Allows for traffic on Port 80"
  vpc_id      = var.vpc_id

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
    Name = "App_SG"
  }
}


# Launching and Instance
# ami-054778af2ffd719dd
# James ami = "ami-040bb941f8d94b312"

resource "aws_instance" "app_instance" {
    ami = var.ami_id
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.app_subnet.id
    security_groups = [aws_security_group.App_SG.id]
    tags = {
      Name = "Terraform-Eng54-Victor-App"
    }
  }






# NACL
# Security Group

# Create Internet Gateway

# Call Module

# Call Module

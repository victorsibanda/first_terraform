
resource "aws_subnet" "db_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.name}-subnet"
  }
}

#network_acl_id
resource "aws_network_acl" "private_nacl" {
  vpc_id = var.vpc_id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 3000
    to_port    = 3000
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 1024
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 27107
    to_port    = 27107
  }

  tags = {
    Name = "${var.name}-private-NACL"
  }
}

resource "aws_security_group" "db_SG" {
  name        = "App-SG"
  description = "Allows for traffic on Port 80"
  vpc_id      = var.vpc_id

  ingress {
    description = "Port 22 from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }

  ingress {
    description = "Port 27107 from public subnet"
    from_port   = 27107
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.2.0/24"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-DB-SG"
  }
}

# #Launching Instance
#
# resource "aws_instance" "db_instance" {
#     ami = db_ami_id
#     instance_type = "t2.micro"
#     associate_public_ip_address = true
#     subnet_id = aws_subnet.db_subnet.id
#     security_groups = [aws_security_group.db_SG.id]
#     tags = {
#       Name = "Terraform-${var.name}"
#     }
#     key_name = "victor-eng54"
#
#
#
# }

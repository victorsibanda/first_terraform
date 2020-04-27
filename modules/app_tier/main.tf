
resource "aws_subnet" "app_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "172.31.87.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "${var.name}-subnet"
  }
}


# Route Table
resource "aws_route_table" "public" {

vpc_id = var.vpc_id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw
  }
  tags = {
    Name = "Route-Table-${var.name}-public"
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

  ingress {
    description = "Port 3000 from anywhere"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Port 22 from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["185.69.144.246/32"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-SG"
  }
}


# Launching and Instance
# ami-054778af2ffd719dd
# James ami = "ami-040bb941f8d94b312"

data "template_file" "app_init" {
  template = "${file("./scripts/app/app_init.sh.tpl")}"
}

resource "aws_instance" "app_instance" {
    ami = var.ami_id
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.app_subnet.id

    security_groups = [aws_security_group.App_SG.id]
    tags = {
      Name = "Terraform-${var.name}"
    }
    key_name = "victor-eng54"
    user_data = data.template_file.app_init.rendered

  #   provisioner "remote-exec" {
  #   inline = [
  #     "cd /home/ubuntu/app",
  #     "sudo chown -R 1000:1000 '/home/ubuntu/.npm'",
  #     "nodejs seeds/seed.js",
  #     "pm2 start app.js",
  #     "echo 'done'"
  #   ]
  # }
  # connection {
  #   type     = "ssh"
  #   user     = "ubuntu"
  #   host = self.public_ip
  #   private_key = "${file("~/.ssh/victor-eng54.pem")}"
  # }


}

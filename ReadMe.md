# Terraform

Terraform is an Orchestration Tool, that is part of infrastructure as code.
Where Chef and Packer sit more on **Configuration Management** Side and create immutable AMIs. Terraform sits on the **orchestration side**. This includes the creation of networks and complex systems and deploys AMIs.

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.


Configuration files describe to Terraform the components needed to run a single application or your entire datacenter. Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.

## Description

This repo allows you to launch an EC2 using Terraform the EC2 uses a previously created AMI which has the Node-Sample-App on it, as well as the required packages. What Terraform does is using an existing VPC, is create a new subnet with new a internet gateway and route table. This allows us to configure what the network settings for the EC2 are. In addition there is a security group set up for the instance. Additionally as this is meant to launch the application when you run it, I used 'remote_exec' to provision npm start to launch the application.


## Usage

- To use this repo you will have to edit the AWS key_name to yours and its file location.

### Prerequisites

- Terraform
- Git
- AWS CLI 2

### Cloning Repository

```
git clone git@github.com:victorsibanda/first_terraform.git
```

### Terraform Commands

- To Initialise folder to use terraform use
```
terraform init
```

- Test's to see if you have necessary AWS resources
```
terraform plan
```

- Applies the changes on main.tf which run the app
```
terraform apply
```

- To destroy all resources created by terraform
```
terraform destroy
```

## Running Scripts

### Template

To run scripts you would use, templates and, create a template file in that repo. The filename would be `{name}.sh.tpl`.

- The Syntax is
```
data "template_file" "init" {
  template = "${file("${path.module}/init.tpl")}"
  vars = {
    consul_address = "${aws_instance.consul.private_ip}"
  }
}
```

### Remote Exec

Alternatively you could use remote exec which allows you to run inline commands but you will need to move over your key pair to allow AWS to use it to ssh into the machine to run the command.

- The syntax is:
```
provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }

```

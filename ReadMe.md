# Terraform

Terraform is an Orchestration Tool, that is part of infrastructure as code.

Where Chef and Packer sit more on **Configuration Management** Side and create immutable AMIs. Terraform sits on the **orchestration side**. This includes the creation of networks and complex systems and deploys AMIs


## Description

This repo allows you to launch an EC2 using Terraform the EC2 uses a previously created AMI which has the Node-Sample-App on it, as well as the required packages. What Terraform does is using an existing VPC, is create a new subnet with new a internet gateway and route table. This allows us to configure what the network settings for the EC2 are. In addition there is a security group set up for the instance. Additionally as this is meant to launch the application when you run it, I used 'remote_exec' to provision npm start to launch the application.

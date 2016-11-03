variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can connect.
Example: ~/.ssh/terraform.pub
$ ssh-add ~/.ssh/terraform
DESCRIPTION
  default = "ssh/insecure-deployer.pub"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "deployerKey"
}

variable "aws_access_key" { 
  description = "AWS access key"
}

variable "aws_secret_key" { 
  description = "AWS secret access key"
}

variable "region"     { 
  description = "AWS region to host your network"
  default     = "us-west-2" 
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.240.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.240.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.240.1.0/24"
}

# Docker 1.12.3 & Docker Compose 1.8.1 installed on Ubuntu 16.04 LTS (x64)
# Image create from EC2 instance created by below command
# docker-machine create --driver amazonec2 --amazonec2-ami ami-a9d276c9 --amazonec2-region us-west-2 --amazonec2-instance-type t2.micro
variable "aws_amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-2 = "ami-3c4dec5c"
  }
}

variable "aws_instance_type" {
  description = "AWS EC2 instance type."
  default     = "t2.medium"
}

variable "app_cloud_config" {
  description = "Early initialization of a cloud instance."
  default     = "cloud-config/app.yml"
}
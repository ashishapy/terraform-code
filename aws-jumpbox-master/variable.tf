variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can connect.
Example: ssh/terraform.pub
$ ssh-add ssh/terraform
DESCRIPTION

  default = "ssh/terraform.pub"
}

variable "aws_amis" {
  description = "Base AMI (ubuntu 16.x lts) to launch the instances with"

  default = {
    us-east-1 = "ami-43a15f3e"
    us-west-2 = "ami-4e79ed36"
  }
}

variable "aws_instance_type" {
  description = "AWS EC2 instance type."
  default     = "t2.medium"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "deployerKey"
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region to host your network"
  default     = "us-east-1"
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

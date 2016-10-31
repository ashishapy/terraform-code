/* Setup our aws provider */
provider "aws" {
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.region}"
}

/* Define our vpc */
resource "aws_vpc" "kube-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags { 
    Name = "kubernetes" 
  }
}

resource "aws_vpc_dhcp_options" "kube-dhcp" {
    domain_name = "us-west-2.compute.internal"
    domain_name_servers = ["AmazonProvidedDNS"]
    tags {
        Name = "kubernetes"
    }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.kube-vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.kube-dhcp.id}"
}
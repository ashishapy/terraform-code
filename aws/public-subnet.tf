/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "kube-ig" {
  vpc_id = "${aws_vpc.kube-vpc.id}"
  tags { 
    Name = "kubernetes" 
  }
}

/* Public subnet */
resource "aws_subnet" "kube-pub" {
  vpc_id            = "${aws_vpc.kube-vpc.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.kube-ig"]
  tags { 
    Name = "kubernetes" 
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "kube-rt" {
  vpc_id = "${aws_vpc.kube-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kube-ig.id}"
  }
  tags { 
    Name = "kubernetes" 
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "kube-rt" {
  subnet_id = "${aws_subnet.kube-pub.id}"
  route_table_id = "${aws_route_table.kube-rt.id}"
}
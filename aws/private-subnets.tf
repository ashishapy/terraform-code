/* Private subnet */
resource "aws_subnet" "kube-priv" {
  vpc_id            = "${aws_vpc.kube-vpc.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = false
  depends_on = ["aws_instance.kube-nat"]
  tags { 
    Name = "Kubernetes" 
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "kube-priv" {
  vpc_id = "${aws_vpc.kube-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.kube-nat.id}"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "kube-priv" {
  subnet_id = "${aws_subnet.kube-priv.id}"
  route_table_id = "${aws_route_table.kube-priv.id}"
}
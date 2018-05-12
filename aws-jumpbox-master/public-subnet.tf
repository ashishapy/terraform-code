/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "py-ig" {
  vpc_id = "${aws_vpc.py-vpc.id}"

  tags {
    Name = "py"
  }
}

/* Public subnet */
resource "aws_subnet" "py-pub" {
  vpc_id                  = "${aws_vpc.py-vpc.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  depends_on              = ["aws_internet_gateway.py-ig"]

  tags {
    Name = "py"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "py-rt" {
  vpc_id = "${aws_vpc.py-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.py-ig.id}"
  }

  tags {
    Name = "py"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "py-rt" {
  subnet_id      = "${aws_subnet.py-pub.id}"
  route_table_id = "${aws_route_table.py-rt.id}"
}

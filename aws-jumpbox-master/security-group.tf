/* Default security group */
resource "aws_security_group" "py-jumpbox-sg" {
  name        = "jumpbox security group"
  description = "jumpbox security group that allows inbound ssh from internet and outbound traffic from all instances in the VPC"
  vpc_id      = "${aws_vpc.py-vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  tags {
    Name = "py"
  }
}

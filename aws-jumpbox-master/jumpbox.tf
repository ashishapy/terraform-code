resource "aws_instance" "py-jumpbox" {
  ami               = "${lookup(var.aws_amis, var.region)}"
  instance_type     = "${var.aws_instance_type}"
  subnet_id         = "${aws_subnet.py-pub.id}"
  security_groups   = ["${aws_security_group.py-jumpbox-sg.id}"]
  key_name          = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false

  tags = {
    Name = "py-jumpbox"
  }
}

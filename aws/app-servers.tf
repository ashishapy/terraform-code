/* App servers */
resource "aws_instance" "app" {
  count = 2
  ami = "${lookup(var.aws_amis, var.region)}"
  instance_type = "${var.aws_instance_type}"
  subnet_id = "${aws_subnet.kube-priv.id}"
  security_groups = ["${aws_security_group.kube-sg.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  user_data = "${file(var.app_cloud_config)}"
  source_dest_check = false
  tags = { 
    Name = "kube-${count.index}"
  }
}

/* Load balancer */
resource "aws_elb" "kube-elb" {
  name = "kubernetes-ELB"
  subnets = ["${aws_subnet.kube-pub.id}"]
  security_groups = ["${aws_security_group.kube-sg.id}", "${aws_security_group.kube-web.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  listener {
    instance_port = 6443
    instance_protocol = "TCP"
    lb_port = 6443
    lb_protocol = "TCP"
  }
  instances = ["${aws_instance.app.*.id}"]
}
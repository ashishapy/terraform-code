output "kube.0.ip" {
  value = "${aws_instance.app.0.private_ip}"
}

output "kube.1.ip" {
  value = "${aws_instance.app.1.private_ip}"
}

output "kube-nat.ip" {
  value = "${aws_instance.kube-nat.public_ip}"
}

output "kube-elb.hostname" {
  value = "${aws_elb.kube-elb.dns_name}"
}
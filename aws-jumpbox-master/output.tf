output "py-jumpbox.ip" {
  value = "${aws_instance.py-jumpbox.public_ip}"
}

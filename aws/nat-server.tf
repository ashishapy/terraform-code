/* NAT/VPN server */
resource "aws_instance" "kube-nat" {
  ami = "${lookup(var.aws_amis, var.region)}"
  instance_type = "${var.aws_instance_type}"
  subnet_id = "${aws_subnet.kube-pub.id}"
  security_groups = ["${aws_security_group.kube-sg.id}", "${aws_security_group.kube-nat.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = { 
    Name = "kubernetes"
  }
  connection {
    user = "ubuntu"
    key_file = "ssh/insecure-deployer"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",
      /* Install docker */ 
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      /* Initialize open vpn data container */
      "sudo mkdir -p /etc/openvpn",
      "sudo docker run --name ovpn-data -v /etc/openvpn busybox",
      /* Generate OpenVPN server config */
      "sudo docker run --volumes-from ovpn-data --rm gosuri/openvpn ovpn_genconfig -p ${var.vpc_cidr} -u udp://${aws_instance.kube-nat.public_ip}"
    ]
  }
}

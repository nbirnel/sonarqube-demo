resource "aws_instance" "salt" {
  count = "${var.count}"

  ami           = "${var.centos7_ami}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key}"
  subnet_id     = "${var.subnet_ids[count.index]}"

  vpc_security_group_ids = [
    "${var.sg_salt}",
    "${var.sg_ssh_manage}",
    "${var.sg_universal_egress}",
  ]

  associate_public_ip_address = true
  private_ip                  = "${cidrhost("${var.subnet_cidrs[count.index]}", 4)}"
  source_dest_check           = true

  connection {
    user        = "${var.user}"
    private_key = "${var.private_key}"
  }

  provisioner = "file" {
    source "${file("${path.module}/files/init")}"
    destination = "/tmp/init"
  }

  provisioner "file" {
    source      = "keys/master"
    destination = "/home/${var.user}/master.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname --static ${format("salt-%02d", count.index + 1)}",
      "sudo /tmp/init",
      "sleep 240",
      "mv /home/${var.user}/master.pem /etc/salt/pki/master.pem",
      "sudo salt-call state.highstate",
    ]
  }

  tags {
    Name       = "${format("salt-%02d", count.index + 1)}"
    department = "${var.department}"
    terraform  = "yes"
  }
}

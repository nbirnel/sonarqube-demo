resource "aws_instance" "sonarqube" {
  count = "${var.count}"

  ami           = "${var.centos7_ami}"
  instance_type = "t2.medium"
  key_name      = "${var.ssh_key}"
  subnet_id     = "${var.subnet_ids[count.index]}"

  vpc_security_group_ids = [
    "${var.sg_sonarqube}",
    "${var.sg_ssh_manage}",
    "${var.sg_universal_egress}",
  ]

  associate_public_ip_address = true
  private_ip                  = "${cidrhost("${var.subnet_cidrs[count.index]}", 4)}"
  source_dest_check           = true

  user_data = "${file("${path.module}/files/init")}"

  connection {
    user        = "${var.user}"
    private_key = "${var.private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname --static ${format("sonarqube-%02d", count.index + 1)}",
    ]
  }

  tags {
    Name       = "${format("sonarqube-%02d", count.index + 1)}"
    department = "${var.department}"
    terraform  = "yes"
  }
}

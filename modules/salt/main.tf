provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_instance" "salt" {
  count = "${var.count}"

  ami           = "${var.centos7_ami}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key}"
  subnet_id = "${var.subnet_ids[count.index]}"

  vpc_security_group_ids = [
    "${var.sg_salt}",
    "${var.sg_ssh_manage}",
    "${var.sg_universal_egress}",
]

  associate_public_ip_address = true
  private_ip                  = "${cidrhost("${var.subnet_cidrs[count.index]}", 4)}"
  source_dest_check           = true

  tags {
    Name       = "${format("salt-%02d", count.index + 1)}"
    department = "${var.department}"
  }
}


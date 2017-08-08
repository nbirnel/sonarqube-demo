module "sonarqube_rta" {
  source = "modules/route_table_association"

  count       = "${var.count["utils"]}"
  route_table = "${aws_route_table.devel-tools.id}"
  subnet_ids  = "${module.subnets.sonarqube_subnet_ids}"
}

module "sonarqube" {
  source = "modules/sonarqube"

  count      = "${var.count["utils"]}"
  department = "${var.department}"

  centos7_ami = "${var.centos7_ami["${var.region}"]}"
  ssh_key     = "${aws_key_pair.deployer.key_name}"

  sg_sonarqube        = "${aws_security_group.sonarqube.id}"
  sg_ssh_manage       = "${aws_security_group.ssh_manage.id}"
  sg_universal_egress = "${aws_security_group.universal_egress.id}"

  salt1_address = "${module.salt.01_private_ip}"
  salt2_address = "${module.salt.02_private_ip}"

  subnet_ids   = "${module.subnets.sonarqube_subnet_ids}"
  subnet_cidrs = "${module.subnets.sonarqube_subnet_cidrs}"

  user        = "centos"
  private_key = "${file("keys/deployer")}"
}

output "sonarqube-01-ssh" {
  value = "ssh -i keys/deployer centos@${module.sonarqube.01_public_ip}"
}

output "sonarqube-02-ssh" {
  value = "ssh -i keys/deployer centos@${module.sonarqube.02_public_ip}"
}

resource "aws_security_group" "sonarqube" {
  name        = "sonarqube"
  description = "salt from our VPC"
  vpc_id      = "${aws_vpc.devel-tools.id}"

  ingress {
    from_port = 9000
    to_port   = 9000
    protocol  = "tcp"

    cidr_blocks = [
      "${var.mgmt_cidrs[0]}",
      "${var.mgmt_cidrs[1]}",
      "${var.mgmt_cidrs[2]}",
    ]
  }

  tags {
    Name       = "sonarqube"
    department = "${var.department}"
    terraform  = "yes"
  }
}

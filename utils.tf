module "utils" {
  source = "modules/utils"

  access_key         = "${var.access_key}"
  secret_key         = "${var.secret_key}"
  region             = "${var.region}"
  count              = "${var.count["utils"]}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.devel-tools.id}"
  department         = "${var.department}"
  availability_zones = "${var.availability_zones}"
}

module "salt" {
  source = "modules/salt"

  access_key         = "${var.access_key}"
  secret_key         = "${var.secret_key}"
  region             = "${var.region}"
  count              = "${var.count["utils"]}"
  department         = "${var.department}"
  
  centos7_ami        = "${var.centos7_ami["${var.region}"]}"
  ssh_key = "${aws_key_pair.deployer.key_name}"

  sg_salt =   "${aws_security_group.salt.id}"
  sg_ssh_manage =   "${aws_security_group.ssh_manage.id}"
  sg_universal_egress =  "${aws_security_group.universal_egress.id}"

  subnet_ids = "${module.utils.subnet_ids}"
  subnet_cidrs = "${module.utils.subnet_cidrs}"

}

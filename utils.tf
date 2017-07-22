module "utils" {
  source = "modules/utils"

  centos7_ami        = "${var.centos7_ami["${var.region}"]}"
  access_key         = "${var.access_key}"
  secret_key         = "${var.secret_key}"
  region             = "${var.region}"
  count              = "${var.count["utils"]}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.devel-tools.id}"
  department         = "${var.department}"
  availability_zones = "${var.availability_zones}"
}

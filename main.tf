provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "aws_vpc" "devel-tools" {
  cidr_block                       = "${var.vpc_cidr}"
  assign_generated_ipv6_cidr_block = true

  tags {
    Name       = "devel-tools"
    department = "${var.department}"
    terraform  = "yes"
  }
}

module "subnets" {
  source = "modules/subnets"

  region             = "${var.region}"
  count              = "${var.count["utils"]}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.devel-tools.id}"
  department         = "${var.department}"
  availability_zones = "${var.availability_zones}"
}

resource "aws_network_acl" "manage" {
  vpc_id = "${aws_vpc.devel-tools.id}"

  subnet_ids = [
    "${module.subnets.utils_subnet_ids}",
    "${module.subnets.sonarqube_subnet_ids}",
  ]

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "${var.mgmt_cidrs[0]}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 110
    action     = "allow"
    protocol   = "-1"
    cidr_block = "${var.mgmt_cidrs[1]}"
  }

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 120
    action     = "allow"
    protocol   = "-1"
    cidr_block = "${var.mgmt_cidrs[2]}"
  }

  egress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }

  tags {
    Name      = "manage"
    env       = "prod"
    terraform = "yes"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer"
  public_key = "${file("keys/deployer.pub")}"
}

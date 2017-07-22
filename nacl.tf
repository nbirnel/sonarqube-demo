resource "aws_network_acl" "manage" {
  vpc_id = "${aws_vpc.devel-tools.id}"

  subnet_ids = [
    "${module.utils.subnet_ids}",
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
    Name = "manage"
    env  = "prod"
  }
}

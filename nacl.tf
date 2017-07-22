resource "aws_network_acl" "manage" {
  vpc_id = "${aws_vpc.devel-tools.id}"

  subnet_ids = [
    "${module.utils.util_subnet_id}",
  ]

  ingress {
    from_port  = 0
    to_port    = 0
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    cidr_block = "${var.mgmt_cidrs[0]}"
    cidr_block = "${var.mgmt_cidrs[1]}"
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
    Name = "allow_all"
    env  = "prod"
  }
}

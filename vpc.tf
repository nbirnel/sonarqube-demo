resource "aws_vpc" "devel-tools" {
  cidr_block = "${var.vpc_cidr}"
  assign_generated_ipv6_cidr_block = true

  tags {
    Name = "devel-tools"
    department = "${var.department}"
  }
}

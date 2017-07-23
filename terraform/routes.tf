resource "aws_internet_gateway" "devel-tools" {
  vpc_id = "${aws_vpc.devel-tools.id}"

  tags {
    Name       = "devel-tools"
    department = "${var.department}"
    terraform  = "yes"
  }
}

resource "aws_route_table" "devel-tools" {
  vpc_id = "${aws_vpc.devel-tools.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.devel-tools.id}"
  }

  tags {
    Name       = "devel-tools"
    department = "${var.department}"
    terraform  = "yes"
  }
}

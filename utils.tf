resource "aws_subnet" "utils-01" {
  vpc_id                  = "${aws_vpc.devel-tools.id}"
  availability_zone       = "${var.region}${var.availability_zones[0]}"
  cidr_block              = "${cidrsubnet("${var.vpc_cidr}", 8, 0)}"
  map_public_ip_on_launch = false

  tags {
    Name       = "utils-01"
    department = "${var.department}"
  }
}

resource "aws_subnet" "utils-02" {
  vpc_id                  = "${aws_vpc.devel-tools.id}"
  availability_zone       = "${var.region}${var.availability_zones[1]}"
  cidr_block              = "${cidrsubnet("${var.vpc_cidr}", 8, 128)}"
  map_public_ip_on_launch = false

  tags {
    Name       = "utils-02"
    department = "${var.department}"
  }
}

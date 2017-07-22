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

resource "aws_instance" "salt-01" {
  ami           = "${var.centos7_ami["${var.region}"]}"
  instance_type = "t2.micro"
  key_name      = ""
  subnet_id     = "${aws_subnet.utils-01.id}"

  vpc_security_group_ids = [
    "${aws_security_group.salt.id}",
  ]

  associate_public_ip_address = true
  private_ip                  = "${cidrhost("${aws_subnet.utils-01.cidr_block}", 4)}"
  source_dest_check           = true

  tags {
    Name       = "salt-01"
    department = "${var.department}"
  }
}

resource "aws_instance" "salt-02" {
  ami           = "${var.centos7_ami["${var.region}"]}"
  instance_type = "t2.micro"
  key_name      = ""
  subnet_id     = "${aws_subnet.utils-02.id}"

  vpc_security_group_ids = [
    "${aws_security_group.salt.id}",
    "${aws_security_group.ssh_manage.id}",
    "${aws_security_group.universal_egress.id}",
  ]

  associate_public_ip_address = true
  private_ip                  = "${cidrhost("${aws_subnet.utils-02.cidr_block}", 4)}"
  source_dest_check           = true

  tags {
    Name       = "salt-02"
    department = "${var.department}"
  }
}


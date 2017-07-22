resource "aws_security_group" "salt" {
  name        = "salt"
  description = "salt from our VPC"
  vpc_id      = "${aws_vpc.devel-tools.id}"

  ingress {
    from_port = 4505
    to_port   = 4506
    protocol  = "tcp"

    cidr_blocks = [
      "${aws_vpc.devel-tools.cidr_block}",
    ]
  }

  tags {
    Name       = "salt"
    department = "${var.department}"
  }
}

resource "aws_security_group" "ssh_manage" {
  name        = "ssh_manage"
  description = "ssh from management subnets"
  vpc_id      = "${aws_vpc.devel-tools.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "${var.mgmt_cidrs[0]}",
      "${var.mgmt_cidrs[1]}",
      "${var.mgmt_cidrs[2]}",
    ]
  }

  tags {
    Name       = "ssh_manage"
    department = "${var.department}"
  }
}

resource "aws_security_group" "universal_egress" {
  name        = "universal_egress"
  description = "out to the universe on all ports"
  vpc_id      = "${aws_vpc.devel-tools.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name       = "universal_egress"
    department = "${var.department}"
  }
}


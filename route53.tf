resource "aws_route53_zone" "develtools-sec" {
  name   = "develtools.sec."
  vpc_id = "${aws_vpc.devel-tools.id}"
  force_destroy = false

  tags {
    Name       = "develtools-sec"
    department = "${var.department}"
    terraform  = "yes"
  }
}

output "develtools-sec-zone-id" {
  value = "${aws_route53_zone.develtools-sec.zone_id}"
}

resource "aws_route53_record" "salt-01" {
  zone_id = "${aws_route53_zone.develtools-sec.zone_id}"
  name    = "salt-01.develtools.sec"
  type    = "A"
  ttl     = "86400"
  records = ["172.30.0.4"]
}

resource "aws_route53_record" "salt-02" {
  zone_id = "${aws_route53_zone.develtools-sec.zone_id}"
  name    = "salt-02.develtools.sec"
  type    = "A"
  ttl     = "86400"
  records = ["172.30.128.4"]
}


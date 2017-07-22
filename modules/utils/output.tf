output "subnet_id" {
  value = "${aws_subnet.utils.id}"
}

output "subnet_ids" {
  value = ["${aws_subnet.utils.*.id}"]
}

output "subnet_cidrs" {
  value = ["${aws_subnet.utils.*.cidr_block}"]
}

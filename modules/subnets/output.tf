output "utils_subnet_ids" {
  value = ["${aws_subnet.utils.*.id}"]
}

output "utils_subnet_cidrs" {
  value = ["${aws_subnet.utils.*.cidr_block}"]
}

output "sonarqube_subnet_ids" {
  value = ["${aws_subnet.sonarqube.*.id}"]
}

output "sonarqube_subnet_cidrs" {
  value = ["${aws_subnet.sonarqube.*.cidr_block}"]
}

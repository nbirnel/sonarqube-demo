output "01_public_ip" {
  value = "${aws_instance.sonarqube.0.public_ip}"
}

output "02_public_ip" {
  value = "${aws_instance.sonarqube.1.public_ip}"
}

output "public_ips" {
  value = "${aws_instance.sonarqube.*.public_ip}"
}

output "sonarqube_public_ip" {
  value = "${aws_instance.sonarqube.public_ip}"
}

output "sonarqube_private_ip" {
  value = "${aws_instance.sonarqube.private_ip}"
}

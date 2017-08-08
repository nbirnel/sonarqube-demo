output "salt_public_ips" {
  value = "${aws_instance.salt.*.public_ip}"
}

output "01_public_ip" {
  value = "${aws_instance.salt.0.public_ip}"
}

output "02_public_ip" {
  value = "${aws_instance.salt.1.public_ip}"
}

output "01_private_ip" {
  value = "${aws_instance.salt.0.private_ip}"
}

output "02_private_ip" {
  value = "${aws_instance.salt.1.private_ip}"
}

output "salt_private_ips" {
  value = "${aws_instance.salt.*.private_ip}"
}

output "salt_public_ip" {
  value = "${aws_instance.salt.public_ip}"
}

output "salt_private_ip" {
  value = "${aws_instance.salt.private_ip}"
}

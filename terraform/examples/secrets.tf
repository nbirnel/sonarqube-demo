variable "access_key" {
  default = "AWS_ACCESS_KEY_CHANGE_ME"
}

variable "secret_key" {
  default = "AWS_SECRET_KEY_CHANGE_ME"
}

variable "mgmt_cidrs" {
  type = "list"

  default = [
    "MY_PUBLIC_CIDR_BLOCK1_CHANGEME",
    "MY_PUBLIC_CIDR_BLOCK2_CHANGEME",
    "MY_PUBLIC_CIDR_BLOCK3_CHANGEME",
  ]
}

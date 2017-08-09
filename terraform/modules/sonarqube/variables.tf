variable "department" {}

variable "centos7_ami" {}

variable "count" {
  default = 1
}

variable "ssh_key" {}

variable "sg_sonarqube" {}
variable "sg_ssh_manage" {}
variable "sg_universal_egress" {}

variable "salt1_address" {}
variable "salt2_address" {}

variable "subnet_ids" {
  type    = "list"
  default = []
}

variable "subnet_cidrs" {
  type    = "list"
  default = []
}

variable "user" {}
variable "private_key" {}

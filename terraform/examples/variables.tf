variable "region" {
  default = "us-west-1"
}

variable "vpc_cidr" {
  default = "172.30.0.0/16"
}

variable "department" {
  default = "development"
}

variable "availability_zones" {
  type    = "list"
  default = ["a", "c"]
}

variable "centos7_ami" {
  type = "map"

  default = {
    "us-east-1" = "ami-ae7bfdb8"
    "us-east-2" = "ami-9cbf9bf9"
    "us-west-1" = "ami-7c280d1c"
    "us-west-2" = "ami-0c2aba6c"
  }
}

variable "count" {
  type = "map"

  default = {
    "utils" = 2
  }
}

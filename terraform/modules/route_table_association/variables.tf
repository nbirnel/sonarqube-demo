variable "route_table" {}

variable "count" {
  default = 1
}

variable "subnet_ids" {
  type    = "list"
  default = []
}

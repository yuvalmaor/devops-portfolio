variable "availability_zones" {
  type = list(string)
}


variable "env" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}
variable "private_cidr_blocks" {
  type = list(string)
}
variable "num_of_subnets" {
  type = number
}
variable "num_route_table" {
  type = number
}
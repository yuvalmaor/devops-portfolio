variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "env" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}
#private_cidr_blocks 

variable "private_cidr_blocks" {
  type = list(string)
}
variable "argo_cd_version" {
  type = string

}

variable "argo_namespace" {
  type = string
}

variable "desired_size" {
  type = number
}


variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}
variable "num_of_subnets" {
  type = number
}
variable "num_route_table" {
  type = number
}


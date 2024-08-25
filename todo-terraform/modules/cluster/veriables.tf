variable "instance_type" {
  type = string
}

variable "env" {
  type = string
}

variable "subnets_id" {
  type = list(string)
}

variable "private_subnets_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "instance_sg" {

}


variable "availability_zones" {
  type = list(string)

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

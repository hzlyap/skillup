variable "skillup_name" {
  type = string
}

variable "knox_id" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_subnet_cidr" {
  type = list
}

variable "private_subnet_cidr" {
  type = list
}

variable "availability_zones" {
  type = list
}

variable "global_tags" {
  type = map
}

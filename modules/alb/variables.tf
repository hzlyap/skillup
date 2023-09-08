variable "skillup_name" {
  type = string
}

variable "knox_id" {
  type = string
}

variable "alb_knox_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list
}

variable "alb_cidr_block" {
  type = list
}

variable "global_tags" {
  type = map
}

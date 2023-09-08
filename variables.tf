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

variable "alb_knox_id" {
  type = string
}

variable "alb_cidr_block" {
  type = list
}

variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "keypair" {
  type = string
}

variable "user_data" {
  type = string
}

variable "asg_min_size" {
  type = number
}

variable "asg_max_size" {
  type = number
}

variable "asg_desired_capacity" {
  type = number
}

variable "global_tags" {
  type = map
}

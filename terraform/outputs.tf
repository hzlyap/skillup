#output "vpc_id" {
#  value = module.vpc.vpc_id
#}

#output "public_subnet_ids" {
#  value = module.vpc.public_subnet_ids
#}

#output "private_subnet_ids" {
#  value = module.vpc.private_subnet_ids
#}

#output "vpc_endpoint_id" {
#  value = module.vpc.vpc_endpoint_id
#}

output "alb_sg_id" {
  value = module.alb.alb_sg_id
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "alb_tg_arn" {
  value = module.alb.alb_tg_arn
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "instance_sg" {
  value = module.asg.instance_sg
}

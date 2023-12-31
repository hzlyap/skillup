output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_tg_arn" {
  value = aws_lb_target_group.alb_tg.*.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

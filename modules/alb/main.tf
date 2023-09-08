resource "aws_security_group" "alb_sg" {
  name   = "Allow HTTP"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.alb_cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-alb-sg-${var.knox_id}-001"
    }
  )
}

resource "aws_lb" "alb" {
  name               = "${var.skillup_name}-alb-${var.alb_knox_id}-001"
  load_balancer_type = "application"
  internal           = false
  subnets            = var.subnet_ids
  security_groups    = ["${aws_security_group.alb_sg.id}"]

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-alb-${var.alb_knox_id}-001"
    }
  )
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.skillup_name}-tg-${var.alb_knox_id}-001"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }

  tags = merge(
    var.global_tags,
    {
      Name = "${var.skillup_name}-tg-${var.alb_knox_id}-001"
    }
  )
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.alb_tg.arn}"
    type             = "forward"
  }
}

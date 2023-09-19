resource "aws_security_group" "asg_sg" {
  name = "Allow HTTP from ALB"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
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
      Name = "${var.skillup_name}-asg-sg-${var.knox_id}-001"
    }
  )
}

resource "aws_launch_template" "lt" {
  name                   = "${var.skillup_name}-lc-${var.knox_id}-001"
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = var.keypair
  vpc_security_group_ids = ["${aws_security_group.asg_sg.id}"]
  user_data              = "${base64encode(var.user_data)}"
  
  iam_instance_profile {
    name = var.iam_instance_profile
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.global_tags,
      {
        Name = "${var.skillup_name}-lt-${var.knox_id}-001"
      }
    )
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = "${var.skillup_name}-asg-${var.knox_id}-001"
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_desired_capacity
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.alb_tg_arn
  
  launch_template {
    id = "${aws_launch_template.lt.id}"
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
   
  tag {
    key = "GBL_CLASS_0"
    value = "SERVICE"
    propagate_at_launch = true
  }

  tag {
    key = "GBL_CLASS_1"
    value = "TEST"
    propagate_at_launch = true
  }

  tag {
    key = "Name"
    value = "${var.skillup_name}-ec2-${var.knox_id}"
    propagate_at_launch = true
  }

  tag {
    key = "Owner"
    value = var.knox_id
    propagate_at_launch = true
  }

  tag {
    key = "Project"
    value = "DA-MLOps"
    propagate_at_launch = true
  }

  tag {
    key = "Team"
    value = "COT"
    propagate_at_launch = true
  }
}

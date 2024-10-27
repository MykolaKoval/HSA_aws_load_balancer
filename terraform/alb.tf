// Target groups
resource "aws_lb_target_group" "tg_uk" { // Target Group UK
  name     = "target-group-uk"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "tg_global" { // Target Group Global
  name     = "target-group-global"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

// Target group attachment
resource "aws_lb_target_group_attachment" "tg_uk_attachment" {
  target_group_arn = aws_lb_target_group.tg_uk.arn
  target_id        = aws_instance.nginx-uk.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_global_attachment" {
  target_group_arn = aws_lb_target_group.tg_global.arn
  target_id        = aws_instance.nginx-global.id
  port             = 80
}

// ALB
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_sg]
  subnets            = [var.subnet_uk, var.subnet_global]
}

// Listener
resource "aws_lb_listener" "app_alb_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_global.arn
  }
}

resource "aws_lb_listener_rule" "rule_uk" {
  listener_arn = aws_lb_listener.app_alb_listener.arn
  priority     = 60

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_uk.arn
  }

  condition {
    query_string {
      key = "server"
      value = "uk"
    }
  }
}

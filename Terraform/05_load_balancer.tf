# ALB setup
resource "aws_lb" "my_alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = aws_subnet.public_subnets[*].id
}

# ALB Target Group
resource "aws_lb_target_group" "my_target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc[0].id
  target_type = "ip"
}

# ALB Listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

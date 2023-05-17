# create alb

resource "aws_lb" "wordpress_alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.subnet_ids.public_1, var.subnet_ids.public_2]
}


# create target group

resource "aws_lb_target_group" "wordpress_tg" {
  name     = "wordpress-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


resource "aws_lb_target_group_attachment" "wordpress_tg_attachment-1" {
  target_group_arn = aws_lb_target_group.wordpress_tg.arn
  target_id        = var.ec2_ids.node_1_private
  port             = 80
}

resource "aws_lb_target_group_attachment" "wordpress_tg_attachment-2" {
  target_group_arn = aws_lb_target_group.wordpress_tg.arn
  target_id        = var.ec2_ids.node_2_private
  port             = 80
}



resource "aws_lb_listener" "wordpress_listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_tg.arn
  }
}






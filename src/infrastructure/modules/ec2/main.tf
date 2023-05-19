resource "aws_key_pair" "wordpress_key_private" {
  key_name   = "wordpress_key"
  public_key = file("~/.ssh/wp_key.pub")
}


data "template_file" "user_data_lamb" {
  template = file("${path.module}/../../../config/install_lamp_stack.sh")
}


data "template_file" "user_data_wordpress" {
  template = file("${path.module}/../../../config/install_wordpress.sh")
}

data "template_file" "user_data_mount_efs" {
  template = file("${path.module}/../../../config/mount_efs.sh")

  vars = {
    efs_dns_name = var.efs_dns_name
  }
}



data "template_file" "user_data_rds" {
  template = file("${path.module}/../../../config/rds.sh")

  vars = {
    db_name  = var.db.db_name
    password = var.db.password
    username = var.db.username
    endpoint = var.db.endpoint
  }
}

resource "aws_instance" "wordpress_bastion" {
  instance_type               = "t2.micro"
  ami                         = data.aws_ami.wordpress_ami.id
  key_name                    = aws_key_pair.wordpress_key_private.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = local.nodes.node_1_bastion.vpc_security_group_ids
  subnet_id                   = local.nodes.node_1_bastion.subnet_id
  tags                        = local.nodes.node_1_bastion.tags
  user_data                   = join("\n", [data.template_file.user_data_lamb.rendered, data.template_file.user_data_wordpress.rendered, data.template_file.user_data_mount_efs.rendered, data.template_file.user_data_rds.rendered])
  root_block_device {
    volume_size = 10
  }
}



resource "aws_launch_configuration" "wordpress_private_config" {
  name                        = "wordpress private machine config"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.wordpress_key_private.key_name
  image_id                    = data.aws_ami.wordpress_ami.image_id
  security_groups             = [var.wb_sg_id]
  associate_public_ip_address = false

  user_data = join("\n", [data.template_file.user_data_lamb.rendered, data.template_file.user_data_mount_efs.rendered])

  root_block_device {
    volume_size = 10
  }
}

resource "aws_autoscaling_group" "wordpress_auto_group" {
  name                 = "wordpress group"
  launch_configuration = aws_launch_configuration.wordpress_private_config.name
  min_size             = 2
  max_size             = 6
  vpc_zone_identifier  = [var.subnet_ids.private_1, var.subnet_ids.private_2]
  target_group_arns    = [var.wordpress_tg_arn]

}


# scaling 

# scale up

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_auto_group.name

  policy_type = "SimpleScaling"

}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_auto_group.name

  policy_type = "SimpleScaling"
}




resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric checks cpu usage"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
}




resource "aws_cloudwatch_metric_alarm" "request_count_high" {
  alarm_name          = "request-count-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "120"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "This metric checks request count"
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
}



resource "aws_cloudwatch_metric_alarm" "request_count_low" {
  alarm_name          = "request-count-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = "120"
  statistic           = "Sum"
  threshold           = "500"
  alarm_description   = "This metric checks request count"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
}





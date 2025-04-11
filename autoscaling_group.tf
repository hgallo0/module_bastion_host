resource "aws_autoscaling_group" "bastion" {
  name                      = var.tagName
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.gracePeriod
  #health_check_type         = "EC2"
  desired_capacity     = var.desired_capacity
  force_delete         = true
  launch_configuration = aws_launch_configuration.as_conf.name
  vpc_zone_identifier  = var.subnet_id
  #availability_zones   = var.azs

  dynamic "tag" {
    for_each = var.asg_tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Class"
    value               = "cs622"
    propagate_at_launch = true
  }
  depends_on = [aws_launch_configuration.as_conf]
}

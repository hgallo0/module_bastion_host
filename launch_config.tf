data "template_file" "default" {
  template = file(var.template_file_path)
}

resource "aws_launch_configuration" "as_conf" {
  image_id             = var.image
  instance_type        = var.instance
  user_data            = data.template_file.default.rendered
  key_name             = var.ssh_key
  security_groups      = [aws_security_group.allow_ssh.id]
  iam_instance_profile = var.bastion_role
  lifecycle {
    create_before_destroy = true
  }
}

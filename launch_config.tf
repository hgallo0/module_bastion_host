data "template_file" "default" {
  template = "${file("templates/data.tpl")}"
}

resource "aws_launch_configuration" "as_conf" {
  #image_id      = data.aws_ami.ubuntu.id
  image_id             = "ami-062f7200baf2fa504"
  instance_type        = "t2.micro"
  user_data            = data.template_file.default.rendered
  key_name             = var.ssh_key
  security_groups      = [aws_security_group.allow_ssh.id]
  iam_instance_profile = var.bastion_role
  lifecycle {
    create_before_destroy = true
  }
}

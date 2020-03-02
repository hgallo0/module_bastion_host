/*data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-*-18.04-amd64-server-*"]
    values = ["amazon-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  #owners = ["099720109477"] # Canonical
  owners = ["020351640293"] # amazon
}*/

/*locals {
  #aggregated_user_data = "${join("\n", var.user_data)}"
  template_path        = "${path.module}/templates/data.sh"
}

data "template_file" "default" {
  template = "${file(local.template_path)}"
}*/

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

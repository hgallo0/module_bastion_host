# module_bastion_host

This Terraform module creates a bastion host with an Auto Scaling Group, Launch Configuration, and Security Group in AWS.

## Features

- **Launch Configuration**: Configures the EC2 instances with a specified AMI, instance type, and user data template.
- **Auto Scaling Group**: Manages the scaling of the bastion host instances across specified subnets and availability zones.
- **Security Group**: Restricts inbound and outbound traffic to the bastion host.

## Resources

- `aws_launch_configuration`
- `aws_autoscaling_group`
- `aws_security_group`

## Inputs

### Launch Configuration Variables

- `ssh_key` (required): The SSH key to log into the EC2 node.
- `bastion_role` (required): The ARN of the instance profile to be attached to the bastion host.
- `template_file_path` (optional): The file path for the user data template. Default: `templates/data.tpl`.
- `image` (optional): The AMI ID to use for the launch configuration. Default: `ami-062f7200baf2fa504`.
- `instance` (optional): The instance type to use for the launch configuration. Default: `t2.micro`.

### Auto Scaling Group Variables

- `max_size` (required): The maximum capacity the Auto Scaling Group can reach.
- `min_size` (required): The minimum capacity the Auto Scaling Group can reach.
- `desired_capacity` (required): The desired capacity of the Auto Scaling Group.
- `subnet_id` (required): The subnets in which the bastion host can reside.
- `azs` (required): The list of availability zones in which the bastion host can reside.
- `gracePeriod` (optional): The health check grace period in seconds. Default: `300`.
- `asg_tags` (optional): A list of tags to apply to the Auto Scaling Group. Default includes:
  - `Name = default-name`
  - `Terraform = true`
  - `Class = cs622`

### Security Group Variables

- `vpc_id` (required): The VPC in which the bastion host should be created.

### General Variables

- `tagName` (required): The name tag for the bastion host.

## Outputs

This module does not define any outputs.

## Usage

```hcl
module "bastion_host" {
  source = "./module_bastion_host"

  ssh_key         = "my-ssh-key"
  bastion_role    = "bastion-role"
  max_size        = 3
  min_size        = 1
  desired_capacity = 2
  subnet_id       = ["subnet-abc123", "subnet-def456"]
  azs             = ["us-east-1a", "us-east-1b"]
  vpc_id          = "vpc-123456"
  tagName         = "bastion-host"
}

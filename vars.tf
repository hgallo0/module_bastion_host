# launch config variables
variable "ssh_key" {
  description = "the ssh key to log into the ec2 node"
}
variable "bastion_role" {
  description = "the arn of the instance profile to be attached to the bastion host"
}

# auto scaling group
variable "max_size" {
  description = "the maximan capacity the autoscaling group can reach"
}
variable "min_size" {
  description = "the minimum capacity the autoscaling group can reach"
}
variable "desired_capacity" {
  description = "the capacity the autoscaling group should be set to"
}
variable "subnet_id" {
  #type = list
  description = "the subnets in which the host can live"
}
variable "azs" {
  type        = list
  description = "the list of availability zones in which the host can live"
}

# security groups
variable "vpc_id" {
  description = "the vpc in which the host should be spun up"
}

# server tag name
variable "tagName" {
  description = "Tag Name"
}

variable "gracePeriod" {
  description = "The amount of time, in seconds, after a new EC2 instance comes into service and before Amazon EC2 Auto Scaling starts checking its health status."
  default     = 300
}

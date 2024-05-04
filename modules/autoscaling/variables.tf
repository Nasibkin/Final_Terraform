variable "name" {
  description = "The name prefix used for resources"
  type        = string
  default     = "Final"
}

variable "vpc_id" {
  description = "The ID of the VPC where resources will be deployed"
  type        = string
  default     = ""
}

#EC2 Variables

variable "default_ami_id" {
  description = "The default AMI ID used for launching instances"
  type        = string
  default     = "ami-07caf09b362be10b8"
}

variable "user_specified_ami_id" {
  description = "The user-specified AMI ID for launching instances"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Size of EC2 Instances"
  type        = string
  default     = "t2.micro"
}

variable "max_size" {
  description = "The maximum number of instances in the autoscaling group"
  type        = number
  default     = 6
}

variable "min_size" {
  description = "The minimum number of instances in the autoscaling group"
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "The desired capacity of instances in the autoscaling group"
  type        = number
  default     = 4
}

variable "private_subnet_ids" {
  description = "The list of private subnet IDs"
  type        = list(string)
  default = []
}

variable "public_subnet_ids" {
  description = "The list of public subnet IDs"
  type        = list(string)
  default = []
}

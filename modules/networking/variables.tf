variable "name" {
  description = "The name prefix used for various resource names."
  type        = string
  default     = "nasiba"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "17.0.0.0/16"
}

variable "public_cidrs" {
  description = "List of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["17.0.1.0/24", "17.0.2.0/24", "17.0.3.0/24"]
}

variable "private_cidrs" {
  description = "List of CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["17.0.4.0/24", "17.0.5.0/24", "17.0.6.0/24"]
}

# terraform/variables.tf
variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-2" # Ohio (change if needed)
}

# EC2 Key Pair Name

variable "key_name" {
  description = "AWS EC2 Key Pair Name"
  type        = string
}


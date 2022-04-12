variable "allowed_inbound_cidrs_lb" {
  type        = list(string)
  description = "(Optional) List of CIDR blocks to permit inbound traffic from to load balancer"
  default     = null
}

variable "allowed_inbound_cidrs_ssh" {
  type        = list(string)
  description = "(Optional) List of CIDR blocks to permit for SSH to Vault nodes"
  default     = null
}

variable "aws_region" {
  type       = string
  description = "Region to deploy operator instance to"
  default    = "us-west-2"
}

variable "common_tags" {
  type        = map(string)
  description = "(Optional) Map of common tags for all taggable AWS resources."
  default     = {}
}

variable "instance_type" {
  type        = string
  default     = "m5.large"
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  default     = null
  description = "(Optional) key pair to use for SSH access to instance"
}

variable "node_count" {
  type        = number
  default     = 1
  description = "Number of operator instances to deploy in ASG"
}

variable "private_subnet_tags" {
  type        = map(string)
  description = "Tags which specify the subnets to deploy operator instance into"
  default     = {
    Name = "tf-postgresql-public-us-west-2*"
  }
}

variable "resource_name_prefix" {
  type        = string
  description = "Resource name prefix used for tagging and naming AWS resources"
  default     = "mara"
}

variable "user_supplied_ami_id" {
  type        = string
  description = "(Optional) User-provided AMI ID to use with EC2 instances. If you provide this value, please ensure it will work with the default userdata script (assumes latest version of AL2). Otherwise, please provide your own userdata script using the user_supplied_userdata_path variable."
  default     = null
}

variable "user_supplied_iam_role_name" {
  type        = string
  description = "(Optional) User-provided IAM role name. This will be used for the instance profile provided to the AWS launch configuration."
  default     = null
}

variable "user_supplied_userdata_path" {
  type        = string
  description = "(Optional) File path to custom userdata script being supplied by the user"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where operator instance will be deployed"
  default     = "insert-application-vpc-id-here"
}

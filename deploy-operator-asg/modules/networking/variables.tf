variable "public_subnet_tags" {
  type        = map(string)
  description = "Tags which specify the subnets to deploy instance into"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where operator instance will be deployed"
}

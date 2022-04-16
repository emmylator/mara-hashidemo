variable "instance_class" {
    default = "db.t4g.large"
    description = "Desired RDS instance size"
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets"
  type        = list(string)
  default = ["192.168.7.0/24", "192.168.8.0/24", "192.168.9.0/24"]
}

variable "db_name" {
    default = "tfPostgresql"
    description = "Database name"
}

variable "username" {
    default = "tfPostgresql_op"
    description = "Database root username"
}

variable "monitoring_role_name" {
    default = "mara-rds-monitoring-role"
    description = "CloudWatch monitoring role IAM name"
}

variable "common_tags" {
  type        = map(string)
  description = "Tags for VPC resources"
  default = {
    Application = "dev"
  }
}

variable "resource_name_prefix" {
  description = "Prefix for resource names (e.g. \"prod\")"
  type        = string
  default     = "mara"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = ["192.168.3.0/24", "192.168.4.0/24", "192.168.5.0/24"]
}

variable "public_subnet_tags" {
  type        = map(string)
  description = "Tags for public subnets."
  default = {
    Public = "deploy"
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24"]
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "192.168.0.0/18"
}

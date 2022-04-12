# Choose m5.large or m5.xlarge for small-sized Vault clusters
variable "instance_type" {
    default = "m5.large"
}

variable "lb_certificate_arn" {
    default = "insert-generated-acm-arn-here"
}

variable "leader_tls_servername" {
    default = "insert-generated-servername-here"
}

variable "region" {
    default = "us-west-2"
}

variable "resource_name_prefix" {
    default = "mara"
}

variable "secrets_manager_arn" {
    default = "insert-generated-secrets-arn-here"
}

variable "vault_license_filepath" {
    default = "./vault.hclic"
}

variable "vpc_id" {
  default = "insert-vault-vpc-id"
}

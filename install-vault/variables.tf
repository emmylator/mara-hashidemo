# Choose m5.large or m5.xlarge for small-sized Vault clusters
variable "instance_type" {
    type    = string
    default = "m5.large"
    description = "Desired instance type. RefArch recommends m5.large or m5.xlarge for small clusters."
}

variable "lb_certificate_arn" {
    type    = string
    default = "insert-lb-certificate-arn-here"
    description = "The cert ARN to be used on the Vault LB listener"
}

variable "leader_tls_servername" {
    type    = string
    default = "insert-tls-servername-here"
    description = "The shared DNS SAN of the TLS certs being used"
}

variable "region" {
    type    = string
    default = "us-west-2"
    description = "The region where Vault will be installed"
}

variable "resource_name_prefix" {
    type    = string
    default = "mara"
    description = "Prefix for Vault resources"
}

variable "secrets_manager_arn" {
    type    = string
    default = "insert-secrets-manager-arn-here"
    description = "AWS Secrets Manager ARN where TLS certs are stored"
}

variable "vault_license_filepath" {
    type    = string
    default = "./license/vault.hclic"
    description = "VERY IMPORTANT! This is the Vault Enterprise license path"
}

variable "vault_version" {
    type    = string
    default = "1.10.0-1"
    description = "Vault Enterprise version to install on nodes"
}

variable "vpc_id" {
    type    = string
    default = "insert-vault-vpc-id-here"
    description = "VPC ID for the Vault (not Application) VPC"
}

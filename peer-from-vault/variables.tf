variable "region" {
  default = "us-west-2"
}

variable "peer_vpc_id" {
  default = "insert-application-vpc-id-here"
  description = "Accepter VPC (Application)"
}

variable "vpc_id" {
  default = "insert-vault-vpc-id-here"
  description = "Requester VPC (Vault)"
}

variable "app_destination_cidr_block" {
  default = "192.168.0.0/18"
  description = "CIDR block for Application VPC"
}

variable "vault_destination_cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR block for Vault VPC"
}

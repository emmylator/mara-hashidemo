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
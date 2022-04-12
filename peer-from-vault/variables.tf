variable "region" {
  default = "us-west-2"
}

# Accepter VPC (Application)
variable "peer_vpc_id" {
  default = "insert-application-vpc-id-here"
}

# Requester VPC (Vault)
variable "vpc_id" {
  default = "insert-vault-vpc-id-here"
}
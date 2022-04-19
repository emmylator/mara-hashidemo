# Make AWS account ID and VPC metadata available.
# This is added as an output so that other stacks can reference this.
# Required for VPC peering.
data "aws_caller_identity" "current" {}
data "aws_route_tables" "vault" {
  vpc_id = var.vpc_id
}
data "aws_route_tables" "postgres" {
  vpc_id = var.peer_vpc_id
}

# VPC peering connection.
# Establishes a relationship resource between the "vault" and "postgres" VPCs.
resource "aws_vpc_peering_connection" "mesh-vpc-peering" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = var.vpc_id
  auto_accept   = true

  tags = {
    Name = "Vault Peering Connection"
  }
}

# Route rule.
# Creates a new route rule on the "Vault" VPC main route table. All requests
# to the "Postgres" VPC's IP range will be directed to the VPC peering
# connection.
resource "aws_route" "vault2postgres" {
  count                     = length(data.aws_route_tables.vault.ids)
  route_table_id            = tolist(data.aws_route_tables.vault.ids)[count.index]
  destination_cidr_block    = var.app_destination_cidr_block
  vpc_peering_connection_id = resource.aws_vpc_peering_connection.mesh-vpc-peering.id
}

# Route rule.
# Creates a new route rule on the "Postgres" VPC route tables. All
# requests to the "Vault" VPC's IP range will be directed to the VPC
# peering connection.
resource "aws_route" "postgres2vault" {
  count                     = length(data.aws_route_tables.postgres.ids)
  route_table_id            = tolist(data.aws_route_tables.postgres.ids)[count.index]
  destination_cidr_block    = var.vault_destination_cidr_block
  vpc_peering_connection_id = resource.aws_vpc_peering_connection.mesh-vpc-peering.id
}

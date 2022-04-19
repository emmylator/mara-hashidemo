data "aws_security_groups" "vault" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
data "aws_security_groups" "postgres" {
  filter {
    name   = "vpc-id"
    values = [var.peer_vpc_id]
  }
}

# Security Group rule.
# Creates a new SG rule on the "Postgres" security groups. Allows
# Postgres ingres traffic from the "Vault" VPC's IP range to SGs.
resource "aws_security_group_rule" "PostgresIncoming" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [var.vault_destination_cidr_block]
  count             = length(data.aws_security_groups.postgres.ids)
  security_group_id = tolist(data.aws_security_groups.postgres.ids)[count.index]
  description       = "Inbound Postgres Traffic"
}

# Security Group rule.
# Creates a new SG rule on the "Postgres" security groups. Allows
# HTTPS ingress traffic from the "Vault" VPC's IP range to SGs.
resource "aws_security_group_rule" "HTTPSIncoming" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vault_destination_cidr_block]
  count             = length(data.aws_security_groups.postgres.ids)
  security_group_id = tolist(data.aws_security_groups.postgres.ids)[count.index]
  description       = "Inbound HTTPS Traffic"
}

# Security Group rule.
# Creates a new SG rule on the "Postgres" security groups. Allows
# HTTPS egress traffic to the "Vault" VPC's IP range from SGs.
resource "aws_security_group_rule" "HTTPSOutgoing" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vault_destination_cidr_block]
  count             = length(data.aws_security_groups.postgres.ids)
  security_group_id = tolist(data.aws_security_groups.postgres.ids)[count.index]
  description       = "Outbound HTTPS Traffic"
}

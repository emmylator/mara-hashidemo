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
# Creates a new SG rule on the "Vault" security groups. Allows
# Postgres cross-vpc traffic from the "Postgres" VPC's IP range to SGs.

# Security Group rule.
# Creates a new SG rule on the "Postgres" security groups. Allows
# Postgres cross-vpc traffic from the "Vault" VPC's IP range to SGs.
resource "aws_security_group_rule" "VaultIncoming" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  count             = length(data.aws_security_groups.postgres.ids)
  security_group_id = tolist(data.aws_security_groups.postgres.ids)[count.index]
  description       = "Inbound Vault Rule"
}
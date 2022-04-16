module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0.0"

  name = local.name
  cidr = var.vpc_cidr

  azs              = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets   = var.public_subnet_cidrs
  private_subnets  = var.private_subnet_cidrs
  database_subnets = var.database_subnet_cidrs

  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  tags = local.tags
  public_subnet_tags = var.public_subnet_tags
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = ">= 4.0"

  name        = local.name
  description = "PostgreSQL security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = local.tags
}

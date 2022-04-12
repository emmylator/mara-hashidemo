provider "aws" {
  # your AWS region
  region = var.region
}

module "vault-ent" {
  source  = "hashicorp/vault-ent-starter/aws"
  version = "0.1.2"

  # !! new test of provisioning different EC2 instances for the Vault cluster !!
  instance_type = var.instance_type
  # prefix for tagging/naming AWS resources
  resource_name_prefix = var.resource_name_prefix
  # VPC ID you wish to deploy into
  vpc_id = var.vpc_id
  # private subnet tags are required and allow you to filter which
  # subnets you will deploy your Vault nodes into
  private_subnet_tags = {
    Vault = "deploy"
  }
  # AWS Secrets Manager ARN where TLS certs are stored
  secrets_manager_arn = var.secrets_manager_arn
  # The shared DNS SAN of the TLS certs being used
  leader_tls_servername = var.leader_tls_servername
  # The cert ARN to be used on the Vault LB listener
  lb_certificate_arn = var.lb_certificate_arn

  vault_license_filepath = var.vault_license_filepath
}
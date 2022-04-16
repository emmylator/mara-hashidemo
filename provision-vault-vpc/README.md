# Provision a VPC for Vault Enterprise installation

Configuration in this directory creates the following:

- 1x VPC with a 10.0.0.0/16 CIDR block, created with--
  - 1x internet gateway
  - 3x NAT gateways, one per AZ
  - 3x Elastic IPs (for NAT gateways)
  - 6x subnets (3x public, 3x private)
  - Route tables and associations connecting subnets, routing egress internet traffic to local NAT gateways

Following successful deployment, outputs are provided for `private_subnet_tags` and `vpc_id`. Save these values for use later.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform apply -destroy` when you don't need these resources.

## Known Issues

Sometimes this module hangs too long during NAT gateway deployment, causing the rest of the `terraform apply` request to timeout with an error `400` (usually during route creation). Just rerun `terraform apply` to destroy the corrupted routes and rebuild what's left.

# Simple Mesh VPC Peering between Application and Vault demo environments

Configuration in this directory creates the following:

- 1x VPC peering connection, requested from the Vault VPC and auto-accepted by the Application VPC
- Bilateral sets of VPC routes connecting the Application CIDR block (192.168.0.0/18) to the Vault CIDR block (10.0.0.0/16)
- Security group rules in the application security groups to permit incoming Postgres traffic from the Vault VPC
    - Testing purposes only: for use if PSQL is installed on a Vault node instead of a separate EC2 operator instance

## Required Variables

- `region` - The AWS region where VPCs are located
- Accepter VPC `vpc_id` - The `vpc_id` generated from the `provision-postgres-singleaz` module
- Requester VPC `vpc_id` - The `vpc_id` generated from the `provision-vault-vpc` module

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform apply -destroy` when you don't need these resources.
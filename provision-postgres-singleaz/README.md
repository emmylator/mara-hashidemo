# Demo Application Environment Consisting of VPC + RDS

Configuration in this directory creates the following:

- 1x VPC with a 192.168.0.0/18 CIDR block, created with--
    - 1x security group with Postgres access for RDS DB instance
    - 1x database subnet group
    - 1x internet gateway
    - 9x subnets (3x public, 3x private, 3x database)
    - Route tables and associations connecting subnets
- 1x RDS Postgres instance in single-AZ configuration, along with--
    - 1x Database parameter group
    - 1x Cloudwatch monitoring IAM role
    - 2x Cloudwatch monitoring log groups
    - 1x randomized database root password

Following successful deployment, outputs are provided for `db_instance_endpoint`, `db_instance_name`, `db_instance_password`, `db_instance_username`, and `vpc_id`. Use `terraform output <output-name>` to expose sensitive values. Save these values for use later.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform apply -destroy` when you don't need these resources.
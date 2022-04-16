# Demo EC2 Instance Deployment

Demo EC2 instance for deployment into application environments. Pre-installed with Postgres client. Optional step to be used after `provision-postgres-singleaz`.

Configuration in this directory creates the following:

- 1x EC2 IAM instance profile with permission for Session Manager console access
- 1x Security group with egress access for operator EC2 instance
- 1x EC2 Launch Template for operator instance, partially configurable in `variables.tf`
- 1x EC2 Autoscaling Group, set to `desired_capacity = 1`

## Required Variables

- `vpc_id` - The `vpc_id` generated from the `provision-postgres-singleaz` module

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform apply -destroy` when you don't need these resources.

## Accessing the Instance

Open a new Session Manager session from the AWS console.

## Note

The `networking` module currently uses the `aws_subnet_ids` data source, which has been deprecated.

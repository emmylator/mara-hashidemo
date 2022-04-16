# AWS Networking Module -- Deploy with parent `deploy-operator-asg` module.

The `networking` module currently uses the `aws_subnet_ids` data source, which has been deprecated. Update this module to use `aws_subnets` instead.
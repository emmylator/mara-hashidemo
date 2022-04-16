# Self-Signed TLS Configuration for Load Balancer and Vault Nodes

Configuration in this directory creates the following:

- Locally-signed TLS certificates, uploaded to AWS as--
  - 1x AWS Secrets Manager secret containing private keys for Vault nodes
  - 1x AWS ACM TLS certificate for securing the Vault load balancer

Following successful deployment, outputs are provided for `lb_certificate_arn`, `leader_tls_servername`, and `secrets_manager_arn`. Save these values for use with the Vault Enterprise installer later.

## About This Example

The Vault installation module requires you to secure the load balancer that it
creates with an [HTTPS
listener](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html).
It also requires TLS certificates on all the Vault nodes in the cluster. The code in this directory creates self-signed secrets and uploads them to
[AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) as well as [AWS
ACM](https://aws.amazon.com/certificate-manager/).

## Required variables

- `aws_region` - AWS region to deploy resources into
- `resource_name_prefix` - string value to use as base for resource name

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform apply -destroy` when you don't need these resources.

### Security Note:
- The [Terraform State](https://www.terraform.io/docs/language/state/index.html)
  produced by this code has sensitive data (cert private keys) stored in it.
  Please secure your Terraform state using the [recommendations listed
  here](https://www.terraform.io/docs/language/state/sensitive-data.html#recommendations).

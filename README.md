# mara-hashidemo
 Repo for HashiCorp technical demo, presented by Mara Hammond

v0.2 release notes:
* Code review conducted on all modules, revisions all over
* README.MD files updated pretty much everywhere

v0.1 release notes:
* Everything uploaded, final code review not finished
* Ignore README.MD everywhere else--subject to revision

## About This Repo

This repo contains all of the modules needed to–-
* Deploy a Postgres database and EC2 operator in a new application VPC, including IAM instance profiles and security group rules
* Spin up a separate AWS VPC for Vault
* Create self-signed ACM certificates and TLS secrets for use by load balancer and Vault nodes
* Peer the Vault VPC with the application VPC 
* Install Vault in the new VPC

What won’t be covered this time:
* Using Vault UI
* Refactoring application to integrate with Vault tokens (dynamic secrets will still be provisioned)
* Best practices for centralized secrets management, including key namespaces

## Demo Pre-Requisites

To get started with any steps in this demo, validate Vault deployment prerequisites are met.
* An AWS account with console access permissions to Session Manager (use an admin IAM user, not root)
* An AWS IAM user with permissions to deploy Vault (see https://registry.terraform.io/modules/hashicorp/vault-ent-starter/aws/latest), also pasted below
* AWSCLI configured on a local profile to use the IAM credentials
* Terraform 0.13 or later installed
* A Vault Enterprise license

* Ensure your AWS credentials are [configured
  correctly](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
  and have permission to use the following AWS services:
    * Amazon Certificate Manager (ACM)
    * Amazon EC2
    * Amazon Elastic Load Balancing (ALB)
    * AWS Identity & Access Management (IAM)
    * AWS Key Management System (KMS)
    * Amazon Simple Storage Service (S3)
    * Amazon Secrets Manager
    * AWS Systems Manager Session Manager (optional - used to connect to EC2
      instances with Session Manager)
    * Amazon VPC

## License

The majority of this code is modified from a pre-existing module released under the 
Mozilla Public License 2.0. 
Please see [MODULE] (https://registry.terraform.io/modules/hashicorp/vault-ent-starter/aws/latest) 
and [LICENSE](https://github.com/hashicorp/terraform-aws-vault-ent-starter/blob/main/LICENSE)
for more details.

# Vault Enterprise with Integrated Storage - Reference Architecture Installation on AWS

Configuration in this directory creates the following:

- An IAM EC2 instance role for Vault nodes with permissions to--
  - auto-unseal Vault with key stored in S3, encrypted by KMS
  - read from the S3 bucket containing the Vault Enterprise license
  - read from AWS Secrets Manager
  - connect to EC2 instances via Session Manager
  - allow cloud auto-join of Vault nodes
- 1x EC2 Launch template for Vault nodes
- 1x EC2 Autoscaling group, currently set to 5 nodes
- 1x AWS KMS key for encrypting S3 objects
- 1x S3 bucket, containing the Vault Enterprise license, encrypted with KMS
- 1x Application Load Balancer (L7 Elastic Load Balancer) with health checks monitoring Vault EC2 cluster
- 1x Security groups for Vault nodes
- Security group rules permitting--
  - gossip protocol traffic between nodes in different AZs (tcp 8200)
  - API requests, request forwarding, and replication traffic (tcp 8201)

## About This Module

This is a Terraform module for provisioning Vault Enterprise with [integrated
storage](https://www.vaultproject.io/docs/concepts/integrated-storage) on AWS.
This module defaults to setting up a cluster with 5 Vault nodes (as recommended
by the [Vault with Integrated Storage Reference
Architecture](https://learn.hashicorp.com/vault/operations/raft-reference-architecture)).
It installs the Enterprise version of Vault 1.10.0-1 (default is 1.8+).

## Required Variables

- `lb_certificate_arn` - The AWS ACM certificate ARN generated from the `generate-tls` module
- `leader_tls_servername` - The Server Common Name defined in the `generate-tls` module
- `secrets_manager_arn` - The AWS Secrets Manager ARN generated from the `generate-tls` module
- `vpc_id` - The Vault `vpc_id` generated from the `provision-vault-vpc` module

## VERY IMPORTANT!!

Vault Enterprise, beginning with version 1.8, requires autoloading of licenses on all nodes. This can be accomplished by placing the vault.hclic file on each server. IN ORDER FOR VAULT TO OPERATE, you must place your Vault Enterprise license (vault.hclic) in the root of the `install-vault/license` folder.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform apply -destroy` when you don't need these resources.

## Note

At apply, Terraform may warn that certain requests are deprecated in the Vault installer. This is expected behavior as AWS has made service-side changes since the last publication of the `hashicorp/vault-ent-starter/aws` module. These warnings will be remedied in a future version of the module.

## Post-Install Instructions

  - You must
    [initialize](https://www.vaultproject.io/docs/commands/operator/init#operator-init)
    your Vault cluster after you create it. Begin by logging into your Vault
    cluster using one of the following methods:
      - Using [Session
        Manager](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/session-manager.html)
      - SSH (you must provide the optional SSH key pair through the `key_name`
        variable and set a value for the `allowed_inbound_cidrs_ssh` variable.
          - Please note this Vault cluster is not public-facing. If you want to
            use SSH from outside the VPC, you are required to establish your own
            connection to it (VPN, etc).

  - To initialize the Vault cluster, run the following commands:

```
$ sudo -i
# vault operator init
```

  - This should return back the following output which includes the recovery
    keys and initial root token (omitted here):

```
...
Success! Vault is initialized
```

  - Please securely store the recovery keys and initial root token that Vault
    returns to you.
  - To check the status of your Vault cluster, export your Vault token and run
    the
    [list-peers](https://www.vaultproject.io/docs/commands/operator/raft#list-peers)
    command:

```
# export VAULT_TOKEN="<your Vault token>"
# vault operator raft list-peers
```

- Please note that Vault does not enable [dead server
  cleanup](https://www.vaultproject.io/docs/concepts/integrated-storage/autopilot#dead-server-cleanup)
  by default. You must enable this to avoid manually managing the Raft
  configuration every time there is a change in the Vault ASG. To enable dead
  server cleanup, run the following command:

 ```
# vault operator raft autopilot set-config \
    -cleanup-dead-servers=true \
    -dead-server-last-contact-threshold=10 \
    -min-quorum=3
 ```

- You can verify these settings after you apply them by running the following command:

```
# vault operator raft autopilot get-config
```

## License

This code is modified from a pre-existing module released under the Mozilla Public License 2.0. Please see [MODULE] (https://registry.terraform.io/modules/hashicorp/vault-ent-starter/aws/latest) and 
[LICENSE](https://github.com/hashicorp/terraform-aws-vault-ent-starter/blob/main/LICENSE)
for more details.

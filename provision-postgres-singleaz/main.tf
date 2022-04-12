provider "aws" {
  region = local.region
}

locals {
  name   = "tf-postgresql"
  region = "us-west-2"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

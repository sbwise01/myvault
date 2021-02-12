terraform {
  backend "s3" {
    bucket  = "bw-terraform-state-us-east-1"
    key     = "vault.tfstate"
    region  = "us-east-1"
    profile = "foghorn-io-brad"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "foghorn-io-brad"
}


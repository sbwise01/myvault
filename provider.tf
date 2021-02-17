terraform {
  backend "s3" {
    bucket  = "brad-terraform-state-us-east-1"
    key     = "vault.tfstate"
    region  = "us-east-1"
    profile = "supportfog"
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "supportfog"
}


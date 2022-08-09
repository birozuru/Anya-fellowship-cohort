terraform {
  backend "s3" {
    bucket = "anya-iac-terraform-state"
    key    = "anya-iac-terraform-state/iac-terraform-state.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
#
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile = "default"
  region = "eu-central-1"
}
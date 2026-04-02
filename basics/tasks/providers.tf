# basic terraform provider file

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }

}

# Configure the AWS Provider

provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "ruchit"

  default_tags {
    tags = {
      Project = "cloud-security-labs"
      Track   = "03-iam-least-privilege"
    }
  }
}
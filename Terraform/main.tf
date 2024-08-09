# Terraform version setup
terraform {
  required_version = ">= 1.9.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.58.0"
    }
  }
}

# AWS provider version set up
provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
      Developer   = var.developer
      Architect   = var.architect
      Company     = var.company
    }
  }
}
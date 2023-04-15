terraform {
    backend "s3" {
    bucket         = "tf-remote-state20230415072931803000000002"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "fdadd10a-6db8-4c93-b661-1d3538d3cfb7"
    dynamodb_table = "tf-remote-state-lock"
  }
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 4.0"
    }
    archive = "~> 1.3"
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY


  default_tags {
    tags = {
      env         = var.env
      provider    = var.tf_provider
      platform    = var.platform
      application = var.application
      cost-center = var.cost_center
      owner       = var.owner
      lob         = var.lob
    }
  }
}



terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }

  backend "s3" {
    bucket = "20250506terraform"
    key    = "vpc.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

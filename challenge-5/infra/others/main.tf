terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "20250506terraform"
    key    = "vpc.tfstate"
    region = "us-east-1"
  }
}

output "subnet_ids" {
  value = data.terraform_remote_state.vpc.outputs.subnet_ids
}

provider "aws" {
  region = "us-east-1"
}

module "ec2" {
  source     = "../../modules/ec2"
  subnet_ids = data.terraform_remote_state.vpc.outputs.subnet_ids
}

module "sg" {
  source = "../../modules/sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
}

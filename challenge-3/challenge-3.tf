terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias   = "ro_user"
  profile = "ro-user"
  assume_role {
    role_arn = "arn:aws:iam::911167898938:role/ReadOnlyRole"
  }
}


module "asg" {
  source = "./modules/asg"
}

module "iam" {
  source = "./modules/iam"
}

data "aws_caller_identity" "local" {
  provider = aws.ro_user
}

resource "local_file" "this" {
  content  = data.aws_caller_identity.local.account_id
  filename = "account-number.txt"
}

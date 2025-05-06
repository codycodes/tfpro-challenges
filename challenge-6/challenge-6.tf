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
  region                   = "us-east-1"
  alias                    = "iam-access"
  profile                  = "iam-access"
  shared_config_files      = ["./.aws/config"]
  shared_credentials_files = ["./.aws/credentials"]
}

provider "aws" {
  region                   = "us-east-1"
  alias                    = "ec2-access"
  profile                  = "ec2-access"
  shared_config_files      = ["./.aws/config"]
  shared_credentials_files = ["./.aws/credentials"]
}
provider "aws" {
  region                   = "us-east-1"
  alias                    = "readonly-access"
  profile                  = "readonly-access"
  shared_config_files      = ["./.aws/config"]
  shared_credentials_files = ["./base-folder/default-creds.txt"]
}

resource "aws_security_group" "allow_tls" {
  provider = aws.ec2-access

  name = "demo-firewall"
}

data "aws_caller_identity" "current" {
  provider = aws.readonly-access
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role_policy_attachments_exclusive" "cw_full_access" {
  policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess"]
  role_name   = aws_iam_role.cw_full_access.name
}

resource "aws_iam_role" "cw_full_access" {
  provider = aws.iam-access

  # managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess"] # deprecated
  name = "CloudWatchFullAccess"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

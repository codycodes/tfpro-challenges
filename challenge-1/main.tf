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
  default_tags {
    tags = {
      Environment = var.environement
    }
  }
}
locals {
  random_pet = "welcomed-ferret"
}


resource "aws_iam_user" "lb" {
  count = 3
  name  = "${local.random_pet}-${var.org-name}-${count.index}"
}

# This policy must be associated with all IAM users created through this code.

resource "aws_iam_user_policy" "lb_ro" {
  for_each = { for i, v in aws_iam_user.lb[*] : i => aws_iam_user.lb[i] }

  name = "ec2-describe-policy"
  user = each.value.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_s3_bucket" "example" {
  for_each = toset(var.s3_buckets)
  bucket   = "${local.random_pet}-${each.value}"
}

resource "aws_s3_object" "new" {
  for_each = toset(var.s3_buckets)
  bucket   = aws_s3_bucket.example[each.key].id
  key      = "new.txt"
  content  = "Success"
}

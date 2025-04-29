provider "aws" {
  shared_config_files      = ["/Users/codes/gh/codycodes/tfpro-challenges/challenge-3/.aws/config"]
  shared_credentials_files = ["/Users/codes/gh/codycodes/tfpro-challenges/challenge-3/.aws/credentials"]
  profile                  = "iam"
}

resource "aws_iam_user" "lb" {
  count = 1
  name  = "success-user"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "ec2-describe-policy"
  user = "success-user"
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

  # explicit dependency to prevent 404 user not found
  depends_on = [aws_iam_user.lb[0]]
}


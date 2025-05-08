locals {
  subnet_names = toset(["subnet1", "subnet2"])
}
data "aws_subnet" "challenge_5_vpc" {
  for_each = local.subnet_names
  filter {
    name   = "tag:Name"
    values = ["subnet-${each.key}"]
  }
  filter {
    name = "cidr"
    values = [
      "10.77.1.0/24",
      "10.77.2.0/24",
    ]
  }
}

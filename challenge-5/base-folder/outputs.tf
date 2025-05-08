output "subnet_ids" {
  value = flatten([for subnet in local.subnet_names : data.aws_subnet.challenge_5_vpc[subnet].id])
}

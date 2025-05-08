output "subnet_ids" {
  value = flatten([for subnet in aws_subnet.challenge_5 : subnet.id])
}

output "vpc_id" {
  value = aws_vpc.main.id
}

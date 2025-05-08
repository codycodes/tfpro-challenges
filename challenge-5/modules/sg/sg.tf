variable "vpc_id" {
  type = string
}

resource "aws_security_group" "sg" {
  for_each = toset(["app-1-sg", "app-2-sg"])

  name   = each.key
  vpc_id = var.vpc_id
}

locals {
  rules       = csvdecode(file("./sg.csv"))
  app_1_rules = [for rule in local.rules : rule if rule.description == "app-1" && rule.direction == "in"]
  app_2_rules = [for rule in local.rules : rule if rule.description == "app-2" && rule.direction == "out"]
}

output "rules" {
  value = local.app_1_rules
}

locals {
  sg_map = {
    sg01 = "app-1-sg"
    sg02 = "app-2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_1_sg" {
  for_each = { for rule in local.app_1_rules : "${rule.name}-${rule.port}-${rule.direction}" => rule }

  security_group_id = aws_security_group.sg[local.sg_map[each.value.name]].id
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_block
  from_port         = each.value.port
  to_port           = each.value.port
}
resource "aws_vpc_security_group_egress_rule" "app_1_sg" {
  for_each = { for rule in local.app_2_rules : "${rule.name}-${rule.port}-${rule.direction}" => rule }

  security_group_id = aws_security_group.sg[local.sg_map[each.value.name]].id
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_block
  from_port         = each.value.port
  to_port           = each.value.port
}

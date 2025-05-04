output "running_ec2" {
  value = [
    for i, v in local.instances_to_provision :
    {
      firewall_id = aws_instance.this[i].vpc_security_group_ids
      id          = aws_instance.this[i].id
      region      = local.instances_to_provision[i]["Region"]
      subnet      = aws_instance.this[i].subnet_id
      team        = local.instances_to_provision[i]["Team_Name"]
      type        = local.instances_to_provision[i]["instance_type"]
    }
  ]
}

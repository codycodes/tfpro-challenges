terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

locals {
  aws_instances          = csvdecode(file("./ec2.csv"))
  instances_to_provision = [for instance in local.aws_instances : instance if instance.Region == "us-east-1"]
}

locals {
  instance_map = {
    nano  = "t3.nano"
    micro = "t2.micro"
  }
}

resource "aws_instance" "this" {
  count = length(local.instances_to_provision)

  ami           = local.instances_to_provision[count.index].AMI_ID
  instance_type = local.instance_map[local.instances_to_provision[count.index].instance_type]

  tags = {
    Name = local.instances_to_provision[count.index].Team_Name
  }
}
variable "subnet_ids" {
  type = set(string)
}

resource "aws_instance" "ec2" {
  for_each      = var.subnet_ids
  instance_type = "t2.nano"
  ami           = "ami-0f88e80871fd81e91"
  subnet_id     = each.value
}

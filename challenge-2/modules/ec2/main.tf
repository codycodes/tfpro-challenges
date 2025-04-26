data "aws_ami" "this" {
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20241109"]
  }
}

resource "aws_instance" "this" {
  ami                  = data.aws_ami.this.image_id
  instance_type        = "t2.micro"
  iam_instance_profile = var.iam_instance_profile
}



data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  valid_instance_type = ["t2.micro","t3.micro"]
}

resource "aws_instance" "this" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "Precondition-exe"
  }

  lifecycle {
    precondition {
      condition     = contains(local.valid_instance_type, var.instance_type)
      error_message = "Instance type must be these types ${join(",", local.valid_instance_type)}"
    }
  }
}

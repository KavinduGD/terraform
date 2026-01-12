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
  valid_instance_types = ["t2.micro", "t3.micro"]
}

resource "aws_instance" "this" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.main[0].id

  tags = {
    Name       = "Precondition-exe"
    CostCenter = "Manager"
  }

  lifecycle {

    # create_before_destroy = true
    postcondition {
      condition     = contains(local.valid_instance_types, self.instance_type)
      error_message = "created ec2 instance do not has valid instance type"
    }
  }
}


check "ec2_tag_check" {
  assert {
    condition     = contains(keys(aws_instance.this.tags), "CostCenter")
    error_message = "Ec2 instance should have CostCenter tag"
  }
}




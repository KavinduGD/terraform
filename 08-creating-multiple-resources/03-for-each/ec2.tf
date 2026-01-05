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

data "aws_ami" "nginx" {


filter {
    name   = "name"
    values = ["bitnami-nginx-1.29.4-r01-debian-12-amd64-f5774628-e459-457a-b058-3b513caefdee"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  amis = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
  }
}

resource "aws_instance" "server" {
  count = length(var.ec2_instance_list)

  ami           = local.amis[var.ec2_instance_list[count.index].ami]
  instance_type = var.ec2_instance_list[count.index].instance_type
  subnet_id     = aws_subnet.main[count.index % var.subnet_count].id
}



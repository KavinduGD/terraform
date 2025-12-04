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

resource "aws_instance" "variables_vm" {
  ami           = data.aws_ami.ubuntu.id

  instance_type = var.ec2_instance_type
  
  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
  }

  tags = {
    Name = "variables_vm"
  }
} 
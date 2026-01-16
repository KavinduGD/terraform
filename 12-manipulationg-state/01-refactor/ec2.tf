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

  owners = ["099720109477"]
}

locals {
  ec2_instances = ["web_server", "db_server"]
}

# resource "aws_instance" "new" {

#   for_each = toset(local.ec2_instances)

#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "instance-${each.value}"
#   }
# }

module "compute" {
  source = "./modules/compute"
}


resource "aws_instance" "latest" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "instance"
  }
}



moved {
  from   = aws_instance.new["web_server"]
  to   = module.compute.aws_instance.this
}



moved {
  from   = aws_instance.new["db_server"]
  to   = aws_instance.latest
}
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

resource "aws_key_pair" "ec2-key" {
  key_name   = "my-ec2-key"
  public_key = file("~/.ssh/my-ec2-key.pub")
}

module "ec2_instance" {

  source = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type = "t3.micro"
  key_name      = aws_key_pair.ec2-key.key_name
  monitoring    = true
  subnet_id     = module.vpc.public_subnets[0]
  ami           = data.aws_ami.ubuntu.id
  security_group_ingress_rules = {
    ssh = { from_port = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    description = "Allow SSH" }
  }
  associate_public_ip_address = true


  tags = {
    project = local.project_name
  }
}


output "public_ip" {
  value = module.ec2_instance.public_ip
}




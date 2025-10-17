locals {
  common_tags = {
    Name    = "nginx"
    Manager = "terraform"
    Project = "nginx-server"
  }
}

resource "aws_vpc" "nginx_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = local.common_tags
}

resource "aws_subnet" "nginx_public_subnet" {
  vpc_id     = aws_vpc.nginx_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = local.common_tags
}

resource "aws_internet_gateway" "nginx_vpc_gw" {
  vpc_id = aws_vpc.nginx_vpc.id

  tags = local.common_tags
}

resource "aws_route_table" "nginx_public_subnet_rt" {
  vpc_id = aws_vpc.nginx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx_vpc_gw.id
  }

  tags = local.common_tags
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.nginx_public_subnet.id
  route_table_id = aws_route_table.nginx_public_subnet_rt.id
}

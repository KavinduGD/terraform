resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr

  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "main" {
  for_each = var.subnet_config

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.vpc_config.name}-${each.key}"
    Access = each.value.public ? "Public" : "Private"
  }
}


locals {

  public_subnets = {
    for key, value in var.subnet_config :
    key => value
    if value.public
  }

  private_subnets = {
    for key, value in var.subnet_config :
    key => value
    if !value.public
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  count  = length(keys(local.public_subnets)) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_route_table" "public_rt" {
  count = length(keys(local.public_subnets)) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway[0].id
  }

  tags = {
    Name = var.vpc_config.name

  }
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.public_rt[0].id


}

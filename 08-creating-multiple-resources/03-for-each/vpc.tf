locals {
  project = "count-multiple-resources"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Project = local.project
    Name    = local.project
  }
}

resource "aws_subnet" "main" {
  for_each = var.subnet_configurations_map

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}

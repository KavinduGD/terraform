data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "main" {
  count = 2

  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.${128 + count.index}.0/24"

  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "public"
  }

  lifecycle {
    postcondition {
      condition     = contains(data.aws_availability_zones.available.names, self.availability_zone)
      error_message = "created subnet uis not created in valid availability zone"
    }
  }
}

check "check_subnets_are_divided_to_different_azs" {
  assert {
    condition     = length(toset([for subnet in aws_subnet.main : subnet.availability_zone])) > 1
    error_message = "subnets should be divided in to different azs"
  }
}

output "a" {
  value = length(toset([for subnet in aws_subnet.main : subnet.availability_zone])) > 1
}


output "list" {
  value = [for subnet in aws_subnet.main : subnet.availability_zone]

}

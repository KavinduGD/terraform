data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"

  tags = {
    Name = "public"
  }

  lifecycle {
    postcondition {
      condition = contains(data.aws_availability_zones.available.names , self.availability_zone)
      error_message = "created subnet uis not created in valid availability zone"
    }
  }
}


  
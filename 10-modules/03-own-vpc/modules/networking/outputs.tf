output "vpc_id" {
  description = "Id of the Vpc that we create"
  value       = aws_vpc.main.id
}

output "public_subnets" {
   
  description = "created public subnets with id and availability zone"
  value = {
    for key, value in local.public_subnets :
    key => {
      subnet_id = aws_subnet.main[key].id
      availability_zone    = aws_subnet.main[key].availability_zone
    }

  }
}

output "private_subnets" {
    value = {
    for key, value in local.private_subnets :
    key => {
      subnet_id = aws_subnet.main[key].id
      availability_zone    = aws_subnet.main[key].availability_zone
    }

  }
}
data "aws_vpc" "prod_vpc" {
    tags = {
        env   = "prod"
  } 
    region = "us-east-1"
}

output "prod_vpc_id" {
    description = "prod_vpc"
    value = data.aws_vpc.prod_vpc.id
  
}
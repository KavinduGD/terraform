data "aws_availability_zones" "available" {}

output "azs" {
  value = data.aws_availability_zones.available
}
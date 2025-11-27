data "aws_caller_identity" "current" {}

output "aws_caller_identity" {
  description = "aws caller"
  value = data.aws_caller_identity.current
}

data "aws_region" "current" {}

output "current_aws_region" {
  description = "current aws region"
  value = data.aws_region.current
}

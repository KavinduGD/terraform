terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.14.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


# variable "bucket_name" {
#   description = "the name of the s3 bucket"
#   type = string
#   default = "my-tf-test-bucket-tkg"
# }


# resource "aws_s3_bucket" "my_tf_bucket" {
#   bucket = var.bucket_name
# }

data "aws_s3_bucket" "external_bucket" {
  bucket = "kts-s3"
}
# output "bucket_id" {
#   description = "The ID of the S3 bucket created by Terraform"
#   value       = aws_s3_bucket.my_tf_bucket.id
# }



# locals {
#   local_example = "This is a local variable"
# }

# module "my_module" {
#   source = "./module-example"
# }
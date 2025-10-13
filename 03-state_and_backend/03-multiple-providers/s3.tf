terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  region = "us-west-1"
  alias  = "us-west-1-provider"
}

resource "aws_s3_bucket" "ap-bucket" {
  bucket = "ap-bucket-tkg"
}

resource "aws_s3_bucket" "us-bucket" {
  bucket   = "us-bucket-tkg"
  provider = aws.us-west-1-provider
}
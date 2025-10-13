terraform {

  required_version = "~> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "state-bucket-tkg"
    key    = "04-backends/state.tfstate"
    region = "ap-south-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
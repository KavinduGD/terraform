# Networking Module

1. Create a VPC with a given cidr block.
2. create multiple public and private subnets across multiple availability zones.
3. Output the VPC ID, public subnet IDs, and private subnet IDs.
4. Create an Internet Gateway and a public route table for the public subnets.
5. Associate the public subnets with the public route table.
6. Accept a map variable to define the subnets with their properties.

## Usage

```hcl
module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr = "10.0.0.0/16"
    name = "my-module-vpc"
  }

  subnet_config = {
    public_1 = {
      cidr   = "10.0.1.0/24"
      az     = "ap-south-1a"
      type   = "public"
      public = true
    }
    public_2 = {
      cidr   = "10.0.2.0/24"
      az     = "ap-south-1b"
      public = true
    }
    private_1 = {
      cidr   = "10.0.3.0/24"
      az     = "ap-south-1b"
      type   = "private"
      public = false
    }
  }
}

```

## Inputs

| Name          | Description                                  | Type                                                                              | Default | Required |
| ------------- | -------------------------------------------- | --------------------------------------------------------------------------------- | ------- | :------: |
| vpc_config    | Configuration for the VPC                    | object({ cidr = string, name = string })                                          | n/a     |   yes    |
| subnet_config | Configuration for the subnets within the VPC | map(object({ cidr_block = string, public = optional(bool, false), az = string })) | n/a     |   yes    |

## Outputs

| Name            | Description                                          |
| --------------- | ---------------------------------------------------- |
| vpc_id          | The AWS ID from the created VPC                      |
| public_subnets  | The ID and the availability zone of public subnets.  |
| private_subnets | The ID and the availability zone of private subnets. |

# Terraform Building Blocks

## Terraform block

- **Tells Terraform which providers (plugins) to use.**
  - required_version - specifies the version of Terraform required.
  - provider - a plugin that allows Terraform to interact with a specific cloud provider or service.
  - backend - where Terraform stores its state file (local or remote).

```hcl
terraform {

    required_version = ">= 1.0"

    backend "s3" {
      bucket = "my-terraform-state"
      key    = "path/to/my/key"
      region = "us-east-1"
    }

    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "6.14.0"
        }
    }
}
```

## Provider block

- **Purpose: Configures the provider with details needed to connect.**

```hcl
provider "aws" {
  region = "us-east-1"
}
```

## Resource block

- **Purpose: Defines the infrastructure components to be created or managed.**

```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```

## Data block

- **Purpose: Fetches data from existing infrastructure or external sources.(we just want to use them in terraform)** (not managed by Terraform)

```hcl
data "aws_ami" "example" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["my-ami-*"]
  }
}
```

## Variable block

- **Purpose: Declares input variables to make configurations dynamic and reusable.**

```hcl
variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
}
```

## Output block

- **Purpose: Defines the output values to be displayed after the infrastructure is applied.**

```hcl
output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.example.id
}
```

## Locals block

- **Purpose: Defines local variables to simplify complex expressions and improve readability.**

```hclhcl
locals {
  instance_name = "my-instance-${var.environment}"
}
```

## Module block

- **Import and use reusable Terraform configurations from other files or repositories.**

```hcl
module "MyModule" {
  source = "./path_to_module"
  instance_type = var.instance_type
} '
```

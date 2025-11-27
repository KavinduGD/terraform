# Data block

- Query or retrieve data from API endpoints or other projects that is not managed within the current project.

<img src="./images/data_block.png" width="600"/>

## Usage

- get availability zones in a region from AWS

```hcl
data "aws_availability_zones" "example" {
  state = "available"
}
```

- get information about an existing VPC by its ID

```hclhcl
data "aws_vpc" "example" {
  vpc_id = "vpc-123456"
}
```

- create iam policy document

```hcl
data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::my-bucket"]
  }
}
```

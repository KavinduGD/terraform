# 1️⃣ What does “creating multiple resources” mean?

In Terraform, a resource is something you create/manage in infrastructure, for example:

- an AWS EC2 instance
- an S3 bucket
- a security group
- a Docker container

### 👉 Creating multiple resources means:

- creating many similar resources at once
- without copy-pasting the same resource block again and again

Terraform gives 3 main ways to do this.

# 2️⃣ Method 1: Multiple resource blocks (❌ not recommended)

### Example

```hcl
resource "aws_s3_bucket" "bucket1" {
  bucket = "my-bucket-1"
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "my-bucket-2"
}
```

### Why this is bad

- Repetitive
- Hard to maintain
- Not scalable

Terraform is declarative, so we prefer data-driven solutions.

# 3️⃣ Method 2: count (simple repetition)

### What is count?

count tells Terraform:

> “Create this resource N times”

### Example

```hcl
resource "aws_instance" "server" {
  count = 3

  ami           = "ami-0abcd1234"
  instance_type = "t2.micro"
}
```

### What happens?

Terraform creates:

- aws_instance.server[0]
- aws_instance.server[1]
- aws_instance.server[2]

### Accessing individual instances

`aws_instance.server[0].id`

### When to use count

- ✅ When resources are identical
- ❌ When resources need different values

# 4️⃣ Method 3: for_each (BEST PRACTICE ⭐)

### What is for_each?

for_each lets you create resources from a `list of strings or map`, where each item can have different values.

### Example with a list

```hcl
variable "users" {
  type    = list(string)
  default = ["alice", "bob", "charlie"]
}

resource "aws_iam_user" "users" {
  for_each = toset(var.users)

  name = each.value
}
```

### Key terms explained

- for_each → loops over a collection
- each.value → current item
- toset() → converts list to set (Terraform requires unique keys)

### Created resources

- aws_iam_user.users["alice"]
- aws_iam_user.users["bob"]
- aws_iam_user.users["charlie"]

# 5️⃣ for_each with a map (most powerful)

### Example

```hcl
variable "servers" {
  type = map(object({
    instance_type = string
    ami           = string
  }))
}

resource "aws_instance" "server" {
  for_each = var.servers

  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = each.key
  }
}
```

### Input

```hcl
servers = {
  web = { ami = "ami-111", instance_type = "t2.micro" }
  db  = { ami = "ami-222", instance_type = "t2.small" }
}
```

### Result

- One web server
- One db server
- Different configurations
- Clean and readable

# 6️⃣ count vs for_each (important comparison)

| Feature                | count     | for_each |
| :--------------------- | :-------- | :------- |
| Uses index             | Yes ([0]) | No       |
| Uses keys              | ❌        | ✅       |
| Handles changes safely | ❌        | ✅       |
| Best practice          | ❌        | ⭐⭐⭐   |

### 👉 Rule of thumb

- Use for_each almost always
- Use count only for very simple cases

# 7️⃣ Real-world pattern (recommended)

```hcl
locals {
  environments = {
    dev  = "t2.micro"
    prod = "t2.medium"
  }
}

resource "aws_instance" "app" {
  for_each = local.environments

  ami           = "ami-abc123"
  instance_type = each.value

  tags = {
    Environment = each.key
  }
}
```

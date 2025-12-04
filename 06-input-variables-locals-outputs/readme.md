# Input variables

Input variables allow you to customize the behavior of your Terraform modules without changing the module's code.

## Variable Precedence

<img src="./images/variable-precedenace.png" width=500/>

- If there were no default value defined for a variable, Terraform will prompt the user to provide a value for the variable when running `terraform apply` or `terraform plan`.
- We can add validation rules to input variables to ensure that the provided values meet certain criteria.

🆚 Object vs. Map in Terraform

Terraform has two structured data types:

- `object({...})` → strict, typed structure
- `map(type)` → flexible key-value map

Below is a breakdown:

🔷 1. OBJECT — strongly typed structured data

- Fixed set of attributes
- Each attribute has a defined type
- Terraform validates structure at plan/apply time

Example:

```hcl
variable "user" {
    type = object({
        name  = string
        email = string
        age   = number
    })
}
```

If you pass:

```hcl
user = {
    name  = "John"
    email = "john@x.com"
    age   = "25" # ❌ wrong type → Terraform will fail
}
```

Or if you add extra fields:

```hcl
user = {
    name  = "John"
    email = "john@x.com"
    age   = 25
    phone = "123" # ❌ unknown attribute
}
```

Terraform errors out because the structure is strict.

When to use object:

- You know the structure
- You want validation
- You want schema-like enforcement
- For module inputs (good practice)

🔶 2. MAP — dynamic key-value structure

- Keys are dynamic (not predefined)
- All values must be of the same type
- Less strict than object

Example:

```hcl
variable "tags" {
    type = map(string)
}
```

You can pass anything:

```hcl
tags = {
    env   = "prod"
    owner = "kavindu"
    team  = "devops"
}
```

Keys can change as long as values are strings.

When to use map:

- Tags
- Labels
- Arbitrary configuration
- Input where keys change often
- Flexible dictionaries

## .tfvars files

- A .tfvars file is where you store variable values for Terraform.
- Instead of passing variables via CLI (-var) or environment variables, you put them neatly into a file.

variables.tf

```terraform
variable "instance_type" {
  type = string
}

variable "project_name" {
  type = string
}
```

dev.tfvars

```terraform
instance_type = "t2.micro"
project_name  = "DevProject"
```

prod.tfvars

```terraform
instance_type = "m5.large"
project_name  = "ProdProject"
```

To use a .tfvars file, run:

```bash
terraform apply -var-file="dev.tfvars"
```

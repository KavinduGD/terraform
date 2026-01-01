# What is a for loop in Terraform?

In Terraform, a for loop is used to transform data (lists or maps) into new lists or maps.

## 👉 Important mindset shift

Terraform is declarative, not imperative.

- ❌ You don't "run code line by line"
- ✅ You describe what the final data should look like

So Terraform for loops are expressions, not traditional loops like in JS or Python.

## Basic for loop syntax

### List → List

### List → List (quick reference)

- Components: "for item in list" iterates, "expression" produces each output element.
- Result: a new list with one element per input item (order preserved).

Example — prepend a prefix to each value:

```hcl
variable "animals" {
    type    = list(string)
    default = ["cat", "dog", "rabbit"]
}

output "hosts" {
    value = [for a in var.animals : format("host-%s", a)]
}
```

### Result

```json
["host-cat", "host-dog", "host-rabbit"]
```

Example — include indexes:

```hcl
output "indexed_hosts" {
    value = [for i, a in var.animals : "${i}-${a}"]
}
```

### Result

```json
["0-cat", "1-dog", "2-rabbit"]
```

```hcl
[for item in list : expression]
```

### Map → Map

```hcl
{for key, value in map : key => expression}
```

## Simple example (List → List)

### Input variable

```hcl
variable "names" {
    type    = list(string)
    default = ["dev", "staging", "prod"]
}
```

### Using a for loop

```hcl
output "upper_names" {
    value = [for name in var.names : upper(name)]
}
```

### Result

```json
["DEV", "STAGING", "PROD"]
```

### What's happening?

- `for name in var.names` → loops through each item
- `upper(name)` → transforms each item
- Result is a new list

## Map → Map example (VERY COMMON)

### Input map

```hcl
variable "instance_types" {
    default = {
        dev     = "t2.micro"
        staging = "t2.small"
        prod    = "t2.medium"
    }
}
```

### Transforming the map

```hcl
output "instance_names" {
    value = {
        for env, type in var.instance_types :
        env => "instance-${env}"
    }
}
```

### Result

```json
{
  "dev": "instance-dev",
  "staging": "instance-staging",
  "prod": "instance-prod"
}
```

## Using if condition inside for (FILTERING)

Terraform lets you filter items using `if`.

### Example: keep only prod

```hcl
output "only_prod" {
    value = [
        for name in var.names :
        name
        if name == "prod"
    ]
}
```

### Result

```json
["prod"]
```

👉 This is similar to `.filter()` in JavaScript.

## Map → List example

### Input map

```hcl
variable "instance_types" {
    default = {
        dev     = "t2.micro"
        staging = "t2.small"
        prod    = "t2.medium"
    }
}
```

### Transforming map to list

```hcl
output "env_list" {
    value = [
        for env, type in var.instance_types :
        env
    ]
}
```

## Real-world example: create multiple resources

### Variable

```hcl
variable "ports" {
    default = [80, 443]
}
```

### Resource with for_each

```hcl
resource "aws_security_group_rule" "allow_ports" {
    for_each = toset(var.ports)

    type        = "ingress"
    from_port   = each.value
    to_port     = each.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
```

### Why for_each?

- Terraform uses `for_each` to loop over resources
- `each.value` → current item
- `each.key` → key (if map)

## Splat expressions (Quick guide)

### 1) What is a splat expression?

A splat expression extracts the same attribute from many objects at once — “give me this field from all elements”.

### 2) Why splat exists

When resources create multiple objects (e.g., multiple EC2 instances), you often need a list of one attribute (ids, public_ips, arns). Splat makes this concise and readable.

### 3) Basic syntax

resource[*].attribute

Example:

```hcl
aws_instance.web[*].id
```

This returns the id of every aws_instance.web.

### 4) Real example

```hcl
resource "aws_instance" "web" {
    count         = 3
    ami           = "ami-xxxx"
    instance_type = "t2.micro"
}

output "instance_ids" {
    value = aws_instance.web[*].id
}
```

### Result

```json
["i-01abcd", "i-02abcd", "i-03abcd"]
```

### 5) Conceptually

Terraform treats aws_instance.web as a list of objects:

```hcl
aws_instance.web = [
    { id = "i-01abcd", ... },
    { id = "i-02abcd", ... },
    { id = "i-03abcd", ... }
]
```

`[*].id` means “take id from each object”.

# What is a Terraform function?

A Terraform function is a built-in helper that takes input values and returns a new value.

Think of it like a math or utility function, but used inside Terraform expressions, not as runnable code.

👉 Terraform is declarative
You describe the final value, and functions help calculate or transform data.

## Basic syntax

```hcl
function_name(arg1, arg2, ...)
```

### Example

```hcl
upper("hello")
```

### Result

```json
"HELLO"
```

## Why Terraform functions exist

Terraform functions help you:

- Manipulate strings
- Work with lists & maps
- Handle conditions
- Transform input variables
- Safely handle nulls & defaults

They are expressions, not steps.

## Main categories (with simple examples)

### 1️⃣ String functions

Used to modify or analyze text.

```hcl
upper("terraform")    # "TERRAFORM"
lower("AWS")          # "aws"
length("hello")       # 5
format("Hello %s", "Batman")  # "Hello Batman"
```

📌 Use case: naming resources, formatting tags

### 2️⃣ List functions

Used to work with lists (arrays).

```hcl
length(["a", "b", "c"])             # 3
element(["t2.micro", "t3.micro"], 0) # "t2.micro"
contains(["dev", "prod"], "dev")     # true
```

📌 Use case: selecting instance types, environments

### 3️⃣ Map (object) functions

Used with key–value data.

```hcl
keys({ env = "dev", region = "us-east-1" })    # ["env", "region"]
values({ env = "dev", region = "us-east-1" })  # ["dev", "us-east-1"]
lookup({ dev = "t2.micro", prod = "t3.large" }, "prod", "t2.nano")  # "t3.large"
```

📌 Use case: environment-based configs

### 4️⃣ Numeric functions

```hcl
max(2, 5, 1)  # 5
ceil(3.2)     # 4
```

📌 Use case: scaling rules, limits

### 5️⃣ Conditional & logical helpers

```hcl
coalesce(null, "", "value")  # "value"
try(var.name, "default-name") # uses var.name if exists, otherwise "default-name"
```

📌 VERY IMPORTANT for real projects

### 6️⃣ Type conversion functions

```hcl
tostring(123)  # "123"
tolist("a")    # ["a"]
```

📌 Use case: fixing type mismatch errors

### 7️⃣ File & path functions

```hcl
file("user-data.sh")
abspath("./config")
```

📌 Use case: user-data scripts, templates

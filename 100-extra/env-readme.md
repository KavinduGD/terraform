# Creating Multiple Independent Environments

How do you create multiple independent environments? (dev/prod/staging)

**You must separate the state.**

You have three options:

## ✅ Option 1: Use Terraform Workspaces (simple)

```bash
terraform workspace new dev
terraform apply -var-file=dev.tfvars

terraform workspace new prod
terraform apply -var-file=prod.tfvars
```

**Workspaces** = separate state files but same code.

---

## ✅ Option 2: Use Separate Backend State Paths (cleaner for cloud)

Example (AWS S3 backend):

**dev/backend.hcl:**

```hcl
bucket = "my-tf-state"
key    = "dev/terraform.tfstate"
region = "us-east-1"
```

**prod/backend.hcl:**

```hcl
bucket = "my-tf-state"
key    = "prod/terraform.tfstate"
region = "us-east-1"
```

Then:

```bash
terraform init -backend-config=dev/backend.hcl
terraform apply -var-file=dev.tfvars

terraform init -backend-config=prod/backend.hcl
terraform apply -var-file=prod.tfvars
```

---

## ✅ Option 3: Separate Folders for Each Environment (most common)

```
/environments
    /dev
        main.tf
        dev.tfvars
        backend.hcl
    /prod
        main.tf
        prod.tfvars
        backend.hcl
```

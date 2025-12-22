# Terraform CLI

## Terraform CLI Commands

| Command                     | Description                                                                                                                    |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| terraform init              | Initialize a Terraform working directory                                                                                       |
| terraform validate          | Validate the configuration files                                                                                               |
| terraform fmt               | Format the configuration files                                                                                                 |
| terraform plan              | Create an execution plan                                                                                                       |
| terraform plan --out <file> | writes the execution plan to a file that can be used by `terraform apply`, ensuring that exactly the planned actions are taken |
| terraform apply             | Apply the changes required to reach the desired state                                                                          |
| terraform show              | Provides human-readable output from a state or plan file                                                                       |
| terraform state list        | Lists all resources in the state file, useful for managing and manipulating the state.                                         |
| terraform destroy           | Destroys all resources tracked in the state file                                                                               |
| terraform output            | Extracts the value of an output variable from the state file                                                                   |

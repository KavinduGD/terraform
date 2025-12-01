# Input variables

- Input variables allow you to customize the behavior of your Terraform modules without changing the module's code.

## Variable Precedence

<img src="./images/variable-precedenace.png" width=500/>

- If there were no default value defined for a variable, Terraform will prompt the user to provide a value for the variable when running `terraform apply` or `terraform plan`.

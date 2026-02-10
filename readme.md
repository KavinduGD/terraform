# Terraform Learning Journey

This repository documents my progress and learning through a comprehensive Terraform course. It includes code examples, projects, and exercises covering everything from basic infrastructure as code concepts to advanced state management and modularization.

## What I Learned in This Course

Throughout this repository, I have explored the core concepts of Terraform, gaining hands-on experience with:

- **Terraform Building Blocks**: Mastering the essential components including `provider` blocks to connect with cloud services, `resource` blocks to define infrastructure, `data` sources to fetch existing information, and `terraform` blocks for backend configuration.
- **State Management**: Understanding the crucial role of the state file in mapping configuration to real-world resources. I learned how Terraform uses state to track metadata, manage dependencies, and detect configuration drift.
- **Backend Configuration**: Configuring both local and remote backends (specifically AWS S3) to store state files securely. This includes implementing state locking to prevent concurrent operations from corrupting the state.
- **Input Variables & Validation**: Making configurations dynamic and reusable using input variables. I explored variable precedence (Environment Variables → `terraform.tfvars` → `*.auto.tfvars` → CLI flags) and implemented strict type validation (e.g., distinguishing between `object` and `map` types) to ensure robust code.
- **Outputs & Locals**: Using `output` values to expose important information (like IP addresses) after deployment and passing data between modules. I also utilized `locals` to simplify complex logic and improve code readability.
- **Modules**: Organizing infrastructure code into reusable modules. I learned the distinction between root and child modules, how to pass variables from root to child, and how to retrieve outputs from child back to root, effectively creating a "function-like" structure for infrastructure.
- **Project Structure**: structural changes involved in different types of terraform projects.
- **IAM User Management**: Building a practical project to manage AWS IAM users, groups, and policies as code, reinforcing the concepts of resource creation and association.
- **State Manipulation**: executing advanced operations like `terraform state mv`, `rm`, and `import` to refactor state without destroying resources or to bring existing resources under Terraform management.
- **Object Validation**: Using custom validation rules within variable definitions to enforce specific constraints on inputs.
- **Expression & Functions**: Utilizing Terraform's built-in functions and expressions for dynamic configuration and logic.

## Table of Contents

Navigate to each section to access the code and detailed notes:

### 1. Introduction
- [**Start Here**](./00-introduction)
- [Course Introduction Notes](./00-introduction/readme.md)

### 2. Terraform Building Blocks
- [**Code & Examples**](./01-terrorform_building_blocks)
- [Building Blocks Notes](./01-terrorform_building_blocks/readme.md)

### 3. Basic Commands
- [**Code & Examples**](./02-basic-commands)
- [Basic Commands Notes](./02-basic-commands/readme.md)

### 4. State and Backend
- [**Code & Examples**](./03-state_and_backend)
- [State & Backend Notes](./03-state_and_backend/readme.md)

### 5. Resources
- [**Code & Examples**](./04-resources)
- [Resources Overview](./04-resources/readme.md)
  - [Server Creation Notes](./04-resources/01-server_create/readme.md)
  - [Static Web Hosting Notes](./04-resources/02-static-web-hosting/readme.md)

### 6. Data Sources
- [**Code & Examples**](./05-data)
- [Data Sources Notes](./05-data/readme.md)

### 7. Input Variables, Locals, and Outputs
- [**Code & Examples**](./06-input-variables-locals-outputs)
- [Variables & Outputs Notes](./06-input-variables-locals-outputs/readme.md)

### 8. Expressions and Functions
- [**Code & Examples**](./07-expression-and-functions)
- [Expressions & Functions Notes](./07-expression-and-functions/readm.md)

### 9. Creating Multiple Resources
- [**Code & Examples**](./08-creating-multiple-resources)
- [Multiple Resources Notes](./08-creating-multiple-resources/readme.md)

### 10. Project: IAM User Management
- [**Code & Examples**](./09-IAM-user-management-(project))
- [IAM Project Notes](./09-IAM-user-management-(project)/readme.md)

### 11. Modules
- [**Code & Examples**](./10-modules)
- [Modules Overview](./10-modules/readme.md)
  - [Networking Module Notes](./10-modules/03-own-vpc/modules/networking/README.md)

### 12. Object Validation
- [**Code & Examples**](./11-object-validation)
- [Object Validation Notes](./11-object-validation/readme.md)

### 13. Manipulating State
- [**Code & Examples**](./12-manipulationg-state)
- [State Manipulation Notes](./12-manipulationg-state/readme.md)

### 14. Extra Topics
- [**Code & Examples**](./100-extra)
- [Environment Notes](./100-extra/env-readme.md)

### Exercises
- [**All Exercises**](./exercises)
*(Comprehensive list of markdown exercises for practice)*

### Slides
- [**Course Slides**](./slides)

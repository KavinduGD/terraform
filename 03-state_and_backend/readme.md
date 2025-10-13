# State

<img src="./images/state.png" width="400px" />

- **Map resources from the configuration to real-world-objects.**
- **🛑 contains sensitive data.**
- **Also stores metadata, such as resource dependencies.**
- **Refresh state with the respect to real-world objects before any planning or applying changes.**
- **Essentially to avoid config drift.**

  - Now, suppose someone logs into the AWS Console and manually changes the bucket — for example, they make the ACL public instead of private.
    This causes a configuration drift:

    - Terraform’s state file says: "acl": "private"
    - AWS’s real-world bucket says: "acl": "public".

  - When you next run terraform plan, Terraform detects this drift:
  - It refreshes the state by comparing it with AWS.
  - Then it plans to revert the change back to "private" (to match your .tf configuration).
  - So, the state helps Terraform prevent drift and keep your infrastructure consistent.

- **Sate locking** to prevent concurrent operations that could corrupt the state.

  - When you run terraform apply, Terraform locks the state file to prevent other operations from running concurrently.
  - This ensures that only one operation can modify the state at a time, preventing potential conflicts and corruption.

## Backend

- **Where the state is stored.**
  - **Local backend** (default) stores the state file on your local filesystem.
  - **Remote backend** stores the state file in a remote service, such as AWS S3, HashiCorp Consul, or Terraform Cloud.

<img src="./images/backend.png" width="700px" />

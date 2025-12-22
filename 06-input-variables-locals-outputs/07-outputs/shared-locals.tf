locals {
  project       = "06-locals"
  project_owner = "Kavindu Gihan"
  project_date  = "1025-12-9"
}

locals {
  common_tags = {
    project       = local.project
    project_owner = local.project_owner
    project_date  = local.project_date
    sensitive_tag=var.my_sensitive_tag
  }
}
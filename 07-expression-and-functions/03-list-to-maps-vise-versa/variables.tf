variable "users" {
  type = list(object({
    username = string
    role     = string
  }))
  default = [
    {
      username = "Kavindu"
      role     = "admin"
    },
    {
      username = "Mahinda"
      role     = "manager"
    },
    {
      username = "Mahinda"
      role     = "president"
    },
  ]
}

locals {
  users_map  = { for user in var.users : user.username => user.role... }
  users_map2 = { for user in var.users : user.username => { roles = user.role }... }
}

locals{
 usernames_from_maps= [for key,value in local.users_map : key]
}

output "users_map" {
  value = local.users_map
}

output "users_map2" {
  value = local.users_map2
}

output "usernames_from_maps" {
  value = local.usernames_from_maps
}
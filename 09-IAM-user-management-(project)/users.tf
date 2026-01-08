locals {
  users = yamldecode(file("${path.module}/users.yaml")).users

    role_and_array_of_users_map = {
    for role in distinct(flatten([
      for user in local.users : user.roles
    ])) :
    role => [
      for user in local.users :
      user.username
      if contains(user.roles, role)
    ]
  }
}

resource "aws_iam_user" "users" {
  for_each = toset([for user in local.users : user.username])

  name = each.value
}

resource "aws_iam_user_login_profile" "login_profiles" {
  for_each = aws_iam_user.users

  user            = each.key
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}


output "passwords" {
  sensitive = true
  value = {
    for user, user_login in aws_iam_user_login_profile.login_profiles
    : user => user_login.password
  }
}

output "users" {
  value = local.role_and_array_of_users_map
}
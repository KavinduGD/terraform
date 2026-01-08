locals {
  role_policies = {
    readonly  = ["ReadOnlyAccess"]
    admin     = ["AdministratorAccess"]
    auditor   = ["SecurityAudit"]
    developer = ["AmazonVPCFullAccess", "AmazonEC2FullAccess", "AmazonRDSFullAccess"]
  }

  role_policies_list = flatten([
    for role , policies in local.role_policies :
    [
        for policy in policies: {
             role = role
             policy = policy
        }
           
    ]
  ])
}

data "aws_iam_policy_document" "assume_role_policy" {
  for_each = local.role_and_array_of_users_map
  
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = [ for user in each.value : "arn:aws:iam::767397975047:user/${user}"]
    }
  }
}


resource "aws_iam_role" "roles" {
  for_each = toset(keys(local.role_policies))

  name = each.value
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy[each.value].json
}


data "aws_iam_policy" "managed_policies" {
  
  for_each = toset([for role_and_policy in local.role_policies_list : role_and_policy.policy])
  arn = "arn:aws:iam::aws:policy/${each.value}"
}


resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  count = length(local.role_policies_list)

  role = aws_iam_role.roles[
        local.role_policies_list[count.index].role
  ].name

  policy_arn = data.aws_iam_policy.managed_policies[
    local.role_policies_list[count.index].policy
  ].arn
}

# output "managed_policies" {
#   value = data.aws_iam_policy.managed_policies
# }
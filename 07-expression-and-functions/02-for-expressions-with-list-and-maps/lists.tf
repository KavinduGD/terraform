variable "numbers_list" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname = string,
    lastname  = string
  }))
}

locals {
  double_numbers = [for num in var.numbers_list : num * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 1]
}

locals {
  firstnames = [for name in var.objects_list : name.firstname]
  fullnames  = [for name in var.objects_list : "${name.firstname} ${name.lastname}"]
  namesMap = {for name in var.objects_list: name.firstname=> name.lastname}
}


output "nameMap" {
  value=local.namesMap
}

# output "double_numbers" {
#   value = local.double_numbers
# }

# output "even_numbers" {
#   value = local.even_numbers
# }

# output "fistnames" {
#   value = local.firstnames
# }

# output "fullnames" {
#   value = local.fullnames
# }
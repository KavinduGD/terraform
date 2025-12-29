locals {
  math = 2 + 2
  equality = 2 == 2
  comparison = 10 < 2
  logical_and = true && false

}

output "operator_result" {
  value = {
    math = local.math
    equality = local.equality
    comparison = local.comparison
    logical_and = local.logical_and
  }
}
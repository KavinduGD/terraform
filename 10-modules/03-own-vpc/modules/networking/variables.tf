variable "vpc_config" {
  type = object({
    cidr = string
    name = string
  })
  description = "Cidr of the vpc"

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr))
    error_message = "Valid vpc is required"
  }
}


data "aws_availability_zones" "azs" {
  state = "available"

}

variable "subnet_config" {
  type = map(object({
    cidr   = string
    az     = string
    public = optional(bool, false)
  }))

  validation {
    condition = alltrue(
      [for key, value in var.subnet_config :
        can(cidrnetmask(value.cidr))
      ]
    )
    error_message = "Invalid cidr in the map"
  }

  validation {
    condition = alltrue(
      [for key, value in var.subnet_config :
        contains(data.aws_availability_zones.azs.names, value.az)
      ]
    )
    error_message = "Invalid Az"
  }


  validation {
    condition = alltrue(
      [for key, value in var.subnet_config :
        contains([true, false], value.public)
      ]
    )
    error_message = "Invalid Az"
  }
}


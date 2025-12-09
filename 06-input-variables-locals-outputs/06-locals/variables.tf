variable "ec2_instance_type" {
  type = string
}


variable "ec2_volume_config" {
  type = object({
    type = string
    size = number
  })
  validation {
    condition     = contains(["gp2", "gp3", ], var.ec2_volume_config.type)
    error_message = "only gp2 and gp3 are available."
  }
}

variable "additional_tags" {
  type = map(string)
}

variable "subnet_count" {
  type    = number
  default = 2
}

variable "ec2_instance_list" {
  type = list(object({
    instance_type = string
    ami           = string
  }))

 validation {
    condition = alltrue([
      for inst in var.ec2_instance_list :
      contains(["t2.micro", "t3.micro"], inst.instance_type)
    ])
    error_message = "Only t2.micro and t3.micro instance types are allowed."
  }

  validation {
    condition = alltrue([
      for inst in var.ec2_instance_list :
      contains(["ubuntu", "nginx"], inst.ami)
    ])
    error_message = "Only ubuntu and nginx amis are allowed"
  }

  default = [{
    instance_type = "t3.micro"
    ami           = "ubuntu"
  },
  {
    instance_type = "t2.micro"
    ami           = "nginx"
  }
  ]
}
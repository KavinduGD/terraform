variable "ec2_instance_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet_name   = optional(string, "default")
  }))

  validation {
    condition = alltrue([
      for key,value in var.ec2_instance_map :
      contains(["t2.micro", "t3.micro"], value.instance_type)
    ])
    error_message = "only t2.micro and t2.micro accepted"
  }

 validation {
    condition = alltrue([
      for key,value in var.ec2_instance_map :
      contains(["nginx", "ubuntu"], value.ami)
    ])
    error_message = "only nginx and ubuntu images accepted"
  }
  
  default = {
    ubuntu_1 = {
      instance_type = "t2.micro"
      ami           = "ubuntu"
    }
    nginx_1 = {
      instance_type  = "t3.micro"
      ami = "nginx"
      subnet_name = "subnet1"
    }
  }
}
  
variable "subnet_configurations_map" {
  type = map(string)

validation {
  condition =  alltrue([
    for config in values(var.subnet_configurations_map) :
    can(cidrnetmask(config))
  ])
  error_message = "Invalid cidr block"
}
  default = {
    default = "10.0.0.0/24"
    subnet1 = "10.0.1.0/24"
  }
}
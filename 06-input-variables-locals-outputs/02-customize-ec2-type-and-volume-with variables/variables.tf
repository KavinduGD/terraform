variable "ec2_instance_type" {
  type = string
  description = "ec2 vm type"

  validation {
    condition     = contains(["t2.micro", "t3.micro",], var.ec2_instance_type)
    error_message = "only t2.micro and t3.micro must be added."
  }

  default = "t3.micro"
}

variable "ec2_volume_type" {
  type = string
  description = "ec2 device volume type"

  validation {
    condition     = contains(["gp2", "gp3",], var.ec2_volume_type)
    error_message = "gp2 and gp3 are available."
  }

  default = "gp3"
}

variable "ec2_volume_size" {
  type= number
  description = "ec2 device volume size in gb"
  default = 10
}

# terraform apply -var="ec2_ins tance_type=t2.micro"

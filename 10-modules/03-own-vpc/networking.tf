module "vpc" {
  source = "./modules/networking"

  vpc_config = {
    cidr = "10.0.0.0/16"
    name = "my-module-vpc"
  }

  subnet_config = {
    public_1 = {
      cidr   = "10.0.1.0/24"
      az     = "ap-south-1a"
      type   = "public"
      public = true
    }
    public_2 = {
      cidr   = "10.0.2.0/24"
      az     = "ap-south-1b"
      public = true
    }
    private_1 = {
      cidr   = "10.0.3.0/24"
      az     = "ap-south-1b"
      type   = "private"
      public = false
    }
  }
}


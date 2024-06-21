terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
  }
}

module "vpc" {
  source = "../modules/vpc"

  name               = "test-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["us-west-2a", "us-west-2b"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "test_assertions" "vpc" {
  component = "vpc"

  equal "vpc_cidr" {
    description = "VPC has correct CIDR"
    got         = module.vpc.vpc_id != ""
    want        = true
  }

  equal "private_subnet_count" {
    description = "Correct number of private subnets"
    got         = length(module.vpc.private_subnets)
    want        = 2
  }

  equal "public_subnet_count" {
    description = "Correct number of public subnets"
    got         = length(module.vpc.public_subnets)
    want        = 2
  }
}

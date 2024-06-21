terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "main" {
  source = "../environments/dev"

  region                  = "us-west-2"
  environment             = "test"
  vpc_cidr                = "10.0.0.0/16"
  azs                     = ["us-west-2a", "us-west-2b"]
  private_subnets         = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets          = ["10.0.101.0/24", "10.0.102.0/24"]
  frontend_instance_type  = "t3.micro"
  backend_instance_type   = "t3.small"
  database_instance_type  = "t3.medium"
  key_name                = "test-key"
}

resource "test_assertions" "main" {
  component = "main"

  check "vpc_created" {
    description = "VPC is created"
    condition   = module.main.vpc_id != ""
  }

  check "frontend_instance" {
    description = "Frontend instance has public IP"
    condition   = module.main.frontend_public_ip != ""
  }

  check "backend_instance" {
    description = "Backend instance has private IP"
    condition   = module.main.backend_private_ip != ""
  }

  check "database_instance" {
    description = "Database instance has private IP"
    condition   = module.main.database_private_ip != ""
  }
}

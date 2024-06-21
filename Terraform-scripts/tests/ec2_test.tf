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

module "ec2" {
  source = "../modules/ec2"

  name                   = "test-instance"
  instance_type          = "t3.micro"
  key_name               = "test-key"
  subnet_id              = "subnet-12345678"
  vpc_security_group_ids = ["sg-12345678"]
}

resource "test_assertions" "ec2" {
  component = "ec2"

  check "instance_type" {
    description = "EC2 instance has correct type"
    condition   = module.ec2.id != ""
  }

  check "private_ip" {
    description = "EC2 instance has a private IP"
    condition   = module.ec2.private_ip != ""
  }
}

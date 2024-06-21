provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  name               = "${var.environment}-vpc"
  cidr               = var.vpc_cidr
  azs                = var.azs
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "ec2_frontend" {
  source = "../../modules/ec2"

  name                   = "${var.environment}-frontend"
  instance_type          = var.frontend_instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.frontend.id]
  user_data              = file("${path.module}/../../scripts/user_data.sh")

  tags = {
    Environment = var.environment
    Application = "frontend"
  }
}

module "ec2_backend" {
  source = "../../modules/ec2"

  name                   = "${var.environment}-backend"
  instance_type          = var.backend_instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.backend.id]
  user_data              = file("${path.module}/../../scripts/user_data.sh")

  tags = {
    Environment = var.environment
    Application = "backend"
  }
}

module "ec2_database" {
  source = "../../modules/ec2"

  name                   = "${var.environment}-database"
  instance_type          = var.database_instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.private_subnets[1]
  vpc_security_group_ids = [aws_security_group.database.id]
  user_data              = file("${path.module}/../../scripts/user_data.sh")

  tags = {
    Environment = var.environment
    Application = "database"
  }
}

resource "aws_security_group" "frontend" {
  name        = "${var.environment}-frontend-sg"
  description = "Security group for frontend EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-frontend-sg"
  }
}

resource "aws_security_group" "backend" {
  name        = "${var.environment}-backend-sg"
  description = "Security group for backend EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "HTTP from frontend"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-backend-sg"
  }
}

resource "aws_security_group" "database" {
  name        = "${var.environment}-database-sg"
  description = "Security group for database EC2 instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "MongoDB from backend"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-database-sg"
  }
}

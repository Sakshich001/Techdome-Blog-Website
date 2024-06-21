variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "frontend_instance_type" {
  description = "EC2 instance type for frontend"
  type        = string
}

variable "backend_instance_type" {
  description = "EC2 instance type for backend"
  type        = string
}

variable "database_instance_type" {
  description = "EC2 instance type for database"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

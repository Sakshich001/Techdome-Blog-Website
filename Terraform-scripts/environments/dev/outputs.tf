output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "frontend_public_ip" {
  description = "Public IP of the frontend EC2 instance"
  value       = module.ec2_frontend.public_ip
}

output "backend_private_ip" {
  description = "Private IP of the backend EC2 instance"
  value       = module.ec2_backend.private_ip
}

output "database_private_ip" {
  description = "Private IP of the database EC2 instance"
  value       = module.ec2_database.private_ip
}

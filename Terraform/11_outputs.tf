# Output the VPC ID
output "vpc_id" {
  value = var.create_vpc ? aws_vpc.my_vpc[0].id : data.aws_vpc.existing[0].id
}

# Output the private subnet IDs
output "private_subnet_ids" {
  value = var.create_vpc ? aws_subnet.private_subnets[*].id : data.aws_subnet.existing_private_subnets[*].id
}

# Output the public subnet IDs
output "public_subnet_ids" {
  value = var.create_vpc ? aws_subnet.public_subnets[*].id : data.aws_subnet.existing_public_subnets[*].id
}

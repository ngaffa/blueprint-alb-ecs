# AWS Provider Configuration
variable "region" {
  description = "The AWS region to deploy resources."
}

variable "profile" {
  description = "The AWS CLI profile to use."
}

variable "environment" {
  description = "The environment for the resources (e.g., dev, prod)."
}

variable "project" {
  description = "The name of the project."
}

variable "developer" {
  description = "The name of the developer."
}

variable "architect" {
  description = "The name of the architect."
}

variable "company" {
  description = "The name of the company."
}

# VPC Configuration
variable "create_vpc" {
  description = "Whether to create a new VPC."
  type        = bool
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
}

variable "vpc_name" {
  description = "The name of the VPC."
}

variable "existing_vpc_id" {
  description = "The ID of an existing VPC to use."
}

# Subnet Configuration
variable "private_subnet_cidr_blocks" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
}

variable "private_subnet_azs" {
  description = "The availability zones for the private subnets."
  type        = list(string)
}

variable "public_subnet_azs" {
  description = "The availability zones for the public subnets."
  type        = list(string)
}

variable "private_subnet_name_format" {
  description = "The name format for private subnets."
}

variable "public_subnet_name_format" {
  description = "The name format for public subnets."
}

# Internet Gateway Configuration
variable "igw_name" {
  description = "The name of the Internet Gateway."
}

# Route Table Configuration
variable "public_route_cidr_block" {
  description = "The CIDR block for the public route."
}

variable "public_route_table_name" {
  description = "The name of the public route table."
}

variable "private_route_table_name" {
  description = "The name of the private route table."
}

# ECS Configuration
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster."
}

variable "service_name" {
  description = "The name of the ECS service."
}

# ALB Configuration
variable "alb_name" {
  description = "The name of the Application Load Balancer."
}

variable "target_group_name" {
  description = "The name of the target group for the ALB."
}

# Security Group Configuration
variable "public_sg_name" {
  description = "The name of the public security group."
}

variable "private_sg_1_name" {
  description = "The name of the first private security group."
}

variable "private_sg_2_name" {
  description = "The name of the second private security group."
}

variable "public_cidr" {
  description = "The CIDR block for public access."
}

variable "private_cidr" {
  description = "The CIDR block for private access."
}

# ECR Configuration
variable "ecr_repo_name" {
  description = "The name of the ECR repository."
}

variable "ecr_policy" {
  description = "The path to the ECR lifecycle policy JSON file."
}

# CloudWatch Configuration
variable "log_group_name" {
  description = "The name of the CloudWatch log group."
}

# Route 53 Configuration
variable "route53_zone_name" {
  description = "The name of the Route 53 hosted zone."
}

variable "route53_record_name" {
  description = "The name of the Route 53 record for the ALB."
}

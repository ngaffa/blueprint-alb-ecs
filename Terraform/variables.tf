# variables.tf
variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "ym-dev-cli"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project tag"
  type        = string
  default     = "Blueprints"
}

variable "developer" {
  description = "Developer tag"
  type        = string
  default     = "yiming"
}

variable "architect" {
  description = "Architect tag"
  type        = string
  default     = "Naoufal"
}

variable "company" {
  description = "Company tag"
  type        = string
  default     = "GAFA CLOUD"
}

# variables for VPC optional creation
variable "create_vpc" {
  description = "Flag to determine whether to create a new VPC"
  type        = bool
  default     = true
}

variable "existing_vpc_id" {
  description = "ID of an existing VPC to use if not creating a new one"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR block for the new VPC"
  type        = string
  default     = "12.0.0.0/24"
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets if creating new VPC"
  type        = list(string)
  default     = ["12.0.0.0/26", "12.0.0.64/26"]
}

variable "private_subnet_azs" {
  description = "Availability zones for private subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets if creating new VPC"
  type        = list(string)
  default     = ["12.0.0.128/27", "12.0.0.160/27"]
}

variable "public_subnet_azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
}

# Default empty list indicating these are optional and will only be used if `create_vpc` is false
variable "existing_private_subnet_ids" {
  description = "IDs of existing private subnets to use if not creating new ones"
  type        = list(string)
  default     = []
}

# Default empty list indicating these are optional and will only be used if `create_vpc` is false
variable "existing_public_subnet_ids" {
  description = "IDs of existing public subnets to use if not creating new ones"
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "vpc-ew1-blueprint-ecs"
}

variable "private_subnet_name_format" {
  description = "Format for naming private subnets"
  type        = string
  default     = "private_subnet_%d-ew1-blueprint-ecs-PrivateSubnet-%s"
}

variable "public_subnet_name_format" {
  description = "Format for naming public subnets"
  type        = string
  default     = "public_subnet_%d-ew1-blueprint-ecs-PublicSubnet-%s"
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
  default     = "igw-ew1-blueprint-ecs"
}

variable "public_route_cidr_block" {
  description = "CIDR block for the public route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_route_table_name" {
  description = "Name tag for the public route table"
  type        = string
  default     = "public_rt-ew1-blueprint-ecs"
}

variable "private_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
  default     = "private_rt-ew1-blueprint-ecs"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0bd0f7e25c32e69f6"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "public_instance_name" {
  description = "Name tag for the EC2 instance in the public subnet"
  type        = string
  default     = "EC2_1-ew1-blueprint-ecs-PublicSubnet-a"
}

variable "private_instance_name" {
  description = "Name tag for the EC2 instance in the private subnet"
  type        = string
  default     = "EC2_2-ew1-blueprint-ecs-PrivateSubnet-a"
}

variable "s3_bucket_name" {
  description = "Name for the S3 bucket"
  type        = string
  default     = "S3-bucket-ew1-blueprint-ecs"
}

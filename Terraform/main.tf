# Terraform version setup
terraform {
  required_version = ">= 1.9.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.58.0"
    }
  }
}

# AWS provider version set up
provider "aws" {
  region  = var.region
  profile = var.profile
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
      Developer   = var.developer
      Architect   = var.architect
      Company     = var.company
    }
  }
}

# Create a new VPC if `create_vpc` is true
resource "aws_vpc" "my_vpc" {
  count = var.create_vpc ? 1 : 0

  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Use an existing VPC if `create_vpc` is false
data "aws_vpc" "existing" {
  count = var.create_vpc ? 0 : 1
  id    = var.existing_vpc_id
}

# Create private subnets if `create_vpc` is true
resource "aws_subnet" "private_subnets" {
  count = var.create_vpc ? length(var.private_subnet_cidr_blocks) : 0

  vpc_id            = aws_vpc.my_vpc[0].id
  cidr_block        = element(var.private_subnet_cidr_blocks, count.index)
  availability_zone = element(var.private_subnet_azs, count.index)
  tags = {
    Name = format(var.private_subnet_name_format, count.index + 1, element(var.private_subnet_azs, count.index))
  }
}

# Create public subnets if `create_vpc` is true
resource "aws_subnet" "public_subnets" {
  count = var.create_vpc ? length(var.public_subnet_cidr_blocks) : 0

  vpc_id            = aws_vpc.my_vpc[0].id
  cidr_block        = element(var.public_subnet_cidr_blocks, count.index)
  availability_zone = element(var.public_subnet_azs, count.index)
  tags = {
    Name = format(var.public_subnet_name_format, count.index + 1, element(var.public_subnet_azs, count.index))
  }
}

# Use existing private subnets if `create_vpc` is false
data "aws_subnet" "existing_private_subnets" {
  count = var.create_vpc ? 0 : length(var.existing_private_subnet_ids)
  id    = element(var.existing_private_subnet_ids, count.index)
}

# Use existing public subnets if `create_vpc` is false
data "aws_subnet" "existing_public_subnets" {
  count = var.create_vpc ? 0 : length(var.existing_public_subnet_ids)
  id    = element(var.existing_public_subnet_ids, count.index)
}

# Create an Internet Gateway if creating a new VPC
resource "aws_internet_gateway" "my_igw" {
  count = var.create_vpc ? 1 : 0

  vpc_id = aws_vpc.my_vpc[0].id
  tags = {
    Name = var.igw_name
  }
}

# Create a route table for the public subnets if creating a new VPC
resource "aws_route_table" "my_public_route_table" {
  count = var.create_vpc ? 1 : 0

  vpc_id = aws_vpc.my_vpc[0].id
  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.my_igw[0].id
  }
  tags = {
    Name = var.public_route_table_name
  }
}

# Create a route table for the private subnets if creating a new VPC
resource "aws_route_table" "my_private_route_table" {
  count = var.create_vpc ? 1 : 0

  vpc_id = aws_vpc.my_vpc[0].id
  tags = {
    Name = var.private_route_table_name
  }
}

# Associate the public subnets with the public route table
resource "aws_route_table_association" "public_subnets" {
  count = var.create_vpc ? length(aws_subnet.public_subnets) : 0

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.my_public_route_table[0].id
}

# Associate the private subnets with the private route table
resource "aws_route_table_association" "private_subnets" {
  count = var.create_vpc ? length(aws_subnet.private_subnets) : 0

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.my_private_route_table[0].id
}

# Create an EC2 instance in the first public subnet
resource "aws_instance" "example_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.create_vpc ? aws_subnet.public_subnets[0].id : data.aws_subnet.existing_public_subnets[0].id

  tags = {
    Name = var.public_instance_name
  }
}

# Create an EC2 instance in the first private subnet
resource "aws_instance" "example_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.create_vpc ? aws_subnet.private_subnets[0].id : data.aws_subnet.existing_private_subnets[0].id

  tags = {
    Name = var.private_instance_name
  }
}

# Create S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
}

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

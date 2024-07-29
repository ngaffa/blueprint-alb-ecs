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
      Environment = "dev"
      Project     = "Blueprints"
      Developer   = "yiming"
      Architect   = "Naoufal"
      Company     = "GAFA CLOUD"
    }
  }
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "12.0.0.0/24"
  tags = {
    Name = "vpc-ew1-blueprint-ecs"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "12.0.0.0/26"
  availability_zone = "eu-west-1a" 
  tags = {
    Name = "private_subnet_1-ew1-blueprint-ecs-PrivateSubnet-a"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "12.0.0.64/26"
  availability_zone = "eu-west-1b" 
  tags = {
    Name = "private_subnet_2-ew1-blueprint-ecs-PrivateSubnet-b"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "12.0.0.128/27"
  availability_zone = "eu-west-1a" 
  tags = {
    Name = "public_subnet_1-ew1-blueprint-ecs-PublicSubnet-a"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "12.0.0.160/27"
  availability_zone = "eu-west-1b" 
  tags = {
    Name = "public_subnet_2-ew1-blueprint-ecs-PublicSubnet-b"
  }
}

# Create internet gateway 
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw-ew1-blueprint-ecs"
  }
}

# Create public subnet route table
resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "rtb_public-ew1-blueprint-ecs"
  }
}

# Associate the public subnet to the route table
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.my_public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.my_public_route_table.id
}

# Create private subnet route table
resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "rtb_private-ew1-blueprint-ecs"
  }
}

# Associate the private subnet to the private route table
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.my_private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.my_private_route_table.id
}

# Create EC2 instence
resource "aws_instance" "example_1" {
  ami           = "ami-0bd0f7e25c32e69f6" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "EC2_1-ew1-blueprint-ecs-PublicSubnet-a"
  }
}

resource "aws_instance" "example_2" {
  ami           = "ami-0bd0f7e25c32e69f6" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_1.id

  tags = {
    Name = "EC2_2-ew1-blueprint-ecs-PrivateSubnet-a"
  }
}

# Create S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "S3-bucket-ew1-blueprint-ecs" 

}

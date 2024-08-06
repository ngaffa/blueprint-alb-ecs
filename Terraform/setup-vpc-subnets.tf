# vpc and subnet setup

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

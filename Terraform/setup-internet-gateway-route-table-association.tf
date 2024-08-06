# setup internet gateway

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

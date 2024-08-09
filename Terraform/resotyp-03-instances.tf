# EC2 setup


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

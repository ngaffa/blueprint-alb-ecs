# Public Security Group
resource "aws_security_group" "public_sg" {
  name   = var.public_sg_name
  vpc_id = aws_vpc.my_vpc[0].id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public_cidr]
  }
}

# Private Security Group 1
resource "aws_security_group" "private_sg_1" {
  name   = var.private_sg_1_name
  vpc_id = aws_vpc.my_vpc[0].id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.private_cidr]
  }
}

# Private Security Group 2
resource "aws_security_group" "private_sg_2" {
  name   = var.private_sg_2_name
  vpc_id = aws_vpc.my_vpc[0].id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.private_cidr]
  }
}

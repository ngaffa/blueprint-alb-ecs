# ECR setup
resource "aws_ecr_repository" "my_ecr_repo" {
  name = var.ecr_repo_name
}

resource "aws_ecr_lifecycle_policy" "my_lifecycle_policy" {
  repository = aws_ecr_repository.my_ecr_repo.name
  policy     = file(var.ecr_policy)
}

# ECR API Endpoint
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.my_vpc[0].id
  service_name      = "com.amazonaws.${var.region}.ecr.api"
  route_table_ids   = aws_route_table.my_private_route_table[*].id
}

# ECR DKR Endpoint
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.my_vpc[0].id
  service_name      = "com.amazonaws.${var.region}.ecr.dkr"
  route_table_ids   = aws_route_table.my_private_route_table[*].id
}

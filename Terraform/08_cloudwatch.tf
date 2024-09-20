# CloudWatch
resource "aws_cloudwatch_log_group" "my_log_group" {
  name              = var.log_group_name
  retention_in_days = 7
}

# CloudWatch Endpoint
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id            = aws_vpc.my_vpc[0].id
  service_name      = "com.amazonaws.${var.region}.logs"
  route_table_ids   = aws_route_table.my_private_route_table[*].id
}

# S3 Bucket
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = var.s3_bucket_name
  tags = {
    Name = var.s3_bucket_name
  }
}

resource "aws_s3_bucket_acl" "my_s3_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.bucket
  acl    = "private"
}

# S3 Gateway Endpoint
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id          = aws_vpc.my_vpc[0].id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = aws_route_table.my_private_route_table[*].id
}


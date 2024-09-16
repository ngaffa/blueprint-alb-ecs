# Create S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = var.s3_bucket_name
}


# aws_s3_bucket
# aws_vpc_endpoint (s3)

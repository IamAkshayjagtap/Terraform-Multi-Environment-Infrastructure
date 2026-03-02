resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}-${var.environment}"

  tags = {
    Name = "${var.environment}-bucket"
  }
}
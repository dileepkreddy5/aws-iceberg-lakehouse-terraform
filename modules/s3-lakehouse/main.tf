resource "aws_s3_bucket" "this" {
  for_each = toset([
    "raw",
    "curated",
    "analytics"
  ])

  bucket = "${var.project_name}-${var.environment}-${each.key}"

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = aws_s3_bucket.this

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  for_each = aws_s3_bucket.this

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# =============================================================================
# S3モジュール メイン設定
# =============================================================================

# S3バケットの作成
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = merge(var.tags, {
    Name    = "${var.bucket_name}-website"
    Purpose = "Static Website Hosting"
  })
}

# S3バケットのバージョニング設定
resource "aws_s3_bucket_versioning" "website" {
  count = var.bucket_versioning ? 1 : 0

  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3バケットの暗号化設定
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  count = var.bucket_encryption ? 1 : 0

  bucket = aws_s3_bucket.website.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3バケットのウェブサイト設定
resource "aws_s3_bucket_website_configuration" "website" {
  count = var.enable_website_configuration ? 1 : 0

  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

# S3バケットのパブリックアクセスブロック設定
resource "aws_s3_bucket_public_access_block" "website" {
  count = var.enable_public_access_block ? 1 : 0

  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = false # CloudFrontからのアクセスを許可するためfalseに変更
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3バケットポリシー（CloudFrontからのアクセスのみ許可）
resource "aws_s3_bucket_policy" "website" {
  count = var.enable_bucket_policy ? 1 : 0

  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudFrontAccess"
        Effect = "Allow"
        Principal = {
          CanonicalUser = var.cloudfront_origin_access_identity_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.website]
}

# S3バケットのライフサイクル設定（オプション）
resource "aws_s3_bucket_lifecycle_configuration" "website" {
  count = var.bucket_versioning ? 1 : 0

  bucket = aws_s3_bucket.website.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    filter {
      prefix = ""
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      noncurrent_days = 60
    }
  }
}

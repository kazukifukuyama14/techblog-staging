# =============================================================================
# データソース
# =============================================================================

# 現在のAWSアカウント情報
data "aws_caller_identity" "current" {}

# 現在のAWSリージョン
data "aws_region" "current" {}

# =============================================================================
# ローカル変数
# =============================================================================

locals {
  # プロジェクト名と環境を組み合わせたプレフィックス
  name_prefix = "${var.project_name}-${var.environment}"

  # S3バケット名（自動生成または指定）
  bucket_name = var.s3_bucket_name != null ? var.s3_bucket_name : "${local.name_prefix}-bucket-${random_string.bucket_suffix.result}"

  # 共通タグ
  tags = merge(var.common_tags, {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  })
}

# =============================================================================
# ランダム文字列（S3バケット名の一意性確保）
# =============================================================================

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# =============================================================================
# S3バケット
# =============================================================================

module "s3" {
  source = "./modules/s3"

  bucket_name                           = local.bucket_name
  bucket_versioning                     = var.s3_bucket_versioning
  bucket_encryption                     = var.s3_bucket_encryption
  tags                                  = local.tags
  enable_website_configuration          = true
  index_document                        = "index.html"
  error_document                        = "404.html"
  enable_public_access_block            = true
  enable_bucket_policy                  = true
  cloudfront_origin_access_identity_arn = module.cloudfront.origin_access_identity_arn
}

# =============================================================================
# CloudFrontディストリビューション
# =============================================================================

module "cloudfront" {
  source = "./modules/cloudfront"

  s3_bucket_id           = module.s3.bucket_id
  s3_bucket_arn          = module.s3.bucket_arn
  price_class            = var.cloudfront_price_class
  default_ttl            = var.cloudfront_default_ttl
  min_ttl                = var.cloudfront_min_ttl
  max_ttl                = var.cloudfront_max_ttl
  enable_cloudwatch_logs = var.enable_cloudwatch_logs
  enable_compression     = true
  enable_https           = true
  tags                   = local.tags

  depends_on = [module.s3]
}

# =============================================================================
# CloudWatchロググループ（オプション）
# =============================================================================

resource "aws_cloudwatch_log_group" "main" {
  count = var.enable_cloudwatch_logs ? 1 : 0

  name              = "/aws/cloudfront/${local.name_prefix}"
  retention_in_days = 30

  tags = local.tags
}

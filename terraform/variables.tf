# =============================================================================
# プロジェクト基本設定
# =============================================================================

variable "project_name" {
  description = "プロジェクト名（リソース名のプレフィックスとして使用）"
  type        = string
  default     = "techblog-staging"
}

variable "environment" {
  description = "環境名（staging, production等）"
  type        = string
  default     = "staging"
}

variable "aws_region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}

# =============================================================================
# S3設定
# =============================================================================

variable "s3_bucket_name" {
  description = "S3バケット名（グローバル一意である必要があります）"
  type        = string
  default     = null # 自動生成される場合
}

variable "s3_bucket_versioning" {
  description = "S3バケットのバージョニング設定"
  type        = bool
  default     = true
}

variable "s3_bucket_encryption" {
  description = "S3バケットの暗号化設定"
  type        = bool
  default     = true
}

# =============================================================================
# CloudFront設定
# =============================================================================

variable "cloudfront_price_class" {
  description = "CloudFrontの価格クラス"
  type        = string
  default     = "PriceClass_100" # 北米・ヨーロッパ・アジアのみ
}

variable "cloudfront_default_ttl" {
  description = "CloudFrontのデフォルトTTL（秒）"
  type        = number
  default     = 86400 # 24時間
}

variable "cloudfront_min_ttl" {
  description = "CloudFrontの最小TTL（秒）"
  type        = number
  default     = 0
}

variable "cloudfront_max_ttl" {
  description = "CloudFrontの最大TTL（秒）"
  type        = number
  default     = 31536000 # 1年
}

# =============================================================================
# タグ設定
# =============================================================================

variable "common_tags" {
  description = "全リソースに適用する共通タグ"
  type        = map(string)
  default = {
    Project     = "techblog-staging"
    Environment = "staging"
    ManagedBy   = "Terraform"
    Purpose     = "Static Blog Hosting"
    Owner       = "Developer"
  }
}

# =============================================================================
# ローカル設定
# =============================================================================

variable "local_development" {
  description = "ローカル開発環境フラグ"
  type        = bool
  default     = true
}

variable "enable_cloudwatch_logs" {
  description = "CloudWatchログの有効化"
  type        = bool
  default     = true
}

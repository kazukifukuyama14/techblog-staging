# =============================================================================
# CloudFrontモジュール 変数定義
# =============================================================================

variable "s3_bucket_id" {
  description = "S3バケットのID"
  type        = string
}

variable "s3_bucket_arn" {
  description = "S3バケットのARN"
  type        = string
}

variable "price_class" {
  description = "CloudFrontの価格クラス"
  type        = string
  default     = "PriceClass_100" # 北米・ヨーロッパ・アジアのみ
}

variable "default_ttl" {
  description = "CloudFrontのデフォルトTTL（秒）"
  type        = number
  default     = 86400 # 24時間
}

variable "min_ttl" {
  description = "CloudFrontの最小TTL（秒）"
  type        = number
  default     = 0
}

variable "max_ttl" {
  description = "CloudFrontの最大TTL（秒）"
  type        = number
  default     = 31536000 # 1年
}

variable "tags" {
  description = "リソースに適用するタグ"
  type        = map(string)
  default     = {}
}

variable "enable_cloudwatch_logs" {
  description = "CloudWatchログを有効にするかどうか"
  type        = bool
  default     = true
}

variable "log_bucket_name" {
  description = "CloudWatchログ用のS3バケット名"
  type        = string
  default     = null
}

variable "enable_compression" {
  description = "CloudFrontの圧縮を有効にするかどうか"
  type        = bool
  default     = true
}

variable "enable_https" {
  description = "HTTPSを強制するかどうか"
  type        = bool
  default     = true
}

variable "allowed_methods" {
  description = "許可するHTTPメソッド"
  type        = list(string)
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cached_methods" {
  description = "キャッシュするHTTPメソッド"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "origin_access_identity_iam_arn" {
  description = "CloudFront Origin Access IdentityのIAM ARN"
  type        = string
}

variable "origin_access_identity_path" {
  description = "CloudFront Origin Access Identityのパス"
  type        = string
}

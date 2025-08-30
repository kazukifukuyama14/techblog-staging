# =============================================================================
# S3モジュール 変数定義
# =============================================================================

variable "bucket_name" {
  description = "S3バケット名（グローバル一意である必要があります）"
  type        = string
}

variable "bucket_versioning" {
  description = "S3バケットのバージョニング設定"
  type        = bool
  default     = true
}

variable "bucket_encryption" {
  description = "S3バケットの暗号化設定"
  type        = bool
  default     = true
}

variable "tags" {
  description = "リソースに適用するタグ"
  type        = map(string)
  default     = {}
}

variable "enable_website_configuration" {
  description = "S3バケットのウェブサイト設定を有効にするかどうか"
  type        = bool
  default     = true
}

variable "index_document" {
  description = "インデックスドキュメントの名前"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "エラードキュメントの名前"
  type        = string
  default     = "404.html"
}

variable "enable_public_access_block" {
  description = "パブリックアクセスブロックを有効にするかどうか"
  type        = bool
  default     = true
}

variable "enable_bucket_policy" {
  description = "バケットポリシーを有効にするかどうか"
  type        = bool
  default     = true
}

variable "cloudfront_origin_access_identity_arn" {
  description = "CloudFrontオリジンアクセスアイデンティティのARN"
  type        = string
  default     = null
}

# =============================================================================
# S3モジュール 出力定義
# =============================================================================

output "bucket_id" {
  description = "S3バケットのID"
  value       = aws_s3_bucket.website.id
}

output "bucket_arn" {
  description = "S3バケットのARN"
  value       = aws_s3_bucket.website.arn
}

output "bucket_name" {
  description = "S3バケットの名前"
  value       = aws_s3_bucket.website.bucket
}

output "bucket_domain_name" {
  description = "S3バケットのドメイン名"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "website_endpoint" {
  description = "S3バケットのウェブサイトエンドポイント"
  value       = var.enable_website_configuration ? aws_s3_bucket_website_configuration.website[0].website_endpoint : null
}

output "website_domain" {
  description = "S3バケットのウェブサイトドメイン"
  value       = var.enable_website_configuration ? aws_s3_bucket_website_configuration.website[0].website_domain : null
}

output "bucket_policy_id" {
  description = "S3バケットポリシーのID"
  value       = var.enable_bucket_policy && var.cloudfront_origin_access_identity_arn != null ? aws_s3_bucket_policy.website[0].id : null
}

output "versioning_status" {
  description = "S3バケットのバージョニングステータス"
  value       = var.bucket_versioning ? aws_s3_bucket_versioning.website[0].versioning_configuration[0].status : "Disabled"
}

output "encryption_status" {
  description = "S3バケットの暗号化ステータス"
  value       = var.bucket_encryption ? "Enabled" : "Disabled"
}

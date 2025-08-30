# =============================================================================
# CloudFrontモジュール 出力定義
# =============================================================================

output "distribution_id" {
  description = "CloudFrontディストリビューションのID"
  value       = aws_cloudfront_distribution.main.id
}

output "distribution_arn" {
  description = "CloudFrontディストリビューションのARN"
  value       = aws_cloudfront_distribution.main.arn
}

output "domain_name" {
  description = "CloudFrontディストリビューションのドメイン名"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "hosted_zone_id" {
  description = "CloudFrontディストリビューションのホストゾーンID"
  value       = aws_cloudfront_distribution.main.hosted_zone_id
}

output "origin_access_identity_id" {
  description = "CloudFrontオリジンアクセスアイデンティティのID"
  value       = aws_cloudfront_origin_access_identity.main.id
}

output "origin_access_identity_arn" {
  description = "CloudFrontオリジンアクセスアイデンティティのARN"
  value       = aws_cloudfront_origin_access_identity.main.iam_arn
}

output "origin_access_identity_path" {
  description = "CloudFrontオリジンアクセスアイデンティティのパス"
  value       = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
}

output "cache_policy_id" {
  description = "CloudFrontキャッシュポリシーのID"
  value       = aws_cloudfront_cache_policy.main.id
}

output "status" {
  description = "CloudFrontディストリビューションのステータス"
  value       = aws_cloudfront_distribution.main.status
}

output "etag" {
  description = "CloudFrontディストリビューションのETag"
  value       = aws_cloudfront_distribution.main.etag
}

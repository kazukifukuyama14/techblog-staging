# =============================================================================
# プロジェクト基本情報
# =============================================================================

output "project_info" {
  description = "プロジェクト基本情報"
  value = {
    project_name = var.project_name
    environment  = var.environment
    region       = var.aws_region
    account_id   = data.aws_caller_identity.current.account_id
  }
}

# =============================================================================
# S3バケット情報
# =============================================================================

output "s3_bucket" {
  description = "S3バケット情報"
  value = {
    bucket_id         = module.s3.bucket_id
    bucket_arn        = module.s3.bucket_arn
    bucket_name       = module.s3.bucket_name
    website_endpoint  = module.s3.website_endpoint
    versioning_status = module.s3.versioning_status
    encryption_status = module.s3.encryption_status
  }
}

# =============================================================================
# CloudFront情報
# =============================================================================

output "cloudfront" {
  description = "CloudFront情報"
  value = {
    distribution_id = module.cloudfront.distribution_id
    domain_name     = module.cloudfront.domain_name
    url             = "https://${module.cloudfront.domain_name}"
    status          = module.cloudfront.status
  }
}

# =============================================================================
# 接続情報
# =============================================================================

output "connection_info" {
  description = "接続情報"
  value = {
    s3_website_url = module.s3.website_endpoint
    cloudfront_url = "https://${module.cloudfront.domain_name}"
    local_hugo_url = "http://localhost:1313"
  }
}

# =============================================================================
# セキュリティ情報
# =============================================================================

output "security_info" {
  description = "セキュリティ情報"
  value = {
    s3_bucket_policy                  = module.s3.bucket_policy_id
    cloudfront_origin_access_identity = module.cloudfront.origin_access_identity_id
  }
  sensitive = true
}

# =============================================================================
# デプロイ情報
# =============================================================================

output "deploy_info" {
  description = "デプロイ情報"
  value = {
    s3_bucket_name             = module.s3.bucket_name
    cloudfront_distribution_id = module.cloudfront.distribution_id
    cloudfront_domain_name     = module.cloudfront.domain_name
  }
}

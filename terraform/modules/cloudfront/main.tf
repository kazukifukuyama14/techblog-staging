# =============================================================================
# CloudFrontモジュール メイン設定
# =============================================================================

# CloudFrontディストリビューション
resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = var.price_class
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"

  # オリジン設定（S3 Origin Access Identity使用）
  origin {
    domain_name = "${var.s3_bucket_id}.s3.amazonaws.com"
    origin_id   = "S3-Website-${var.s3_bucket_id}"

    s3_origin_config {
      origin_access_identity = var.origin_access_identity_path
    }
  }

  # デフォルトキャッシュビヘイビア
  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = "S3-Website-${var.s3_bucket_id}"
    viewer_protocol_policy = var.enable_https ? "redirect-to-https" : "allow-all"
    compress               = var.enable_compression

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = var.min_ttl
    default_ttl = var.default_ttl
    max_ttl     = var.max_ttl
  }

  # エラーページ設定（Hugo静的サイト用）
  custom_error_response {
    error_code         = 404
    response_code      = "404"
    response_page_path = "/404.html"
  }

  custom_error_response {
    error_code         = 403
    response_code      = "403"
    response_page_path = "/404.html"
  }

  # ログ設定（オプション）
  dynamic "logging_config" {
    for_each = var.enable_cloudwatch_logs && var.log_bucket_name != null ? [1] : []
    content {
      include_cookies = false
      bucket          = "${var.log_bucket_name}.s3.amazonaws.com"
      prefix          = "cloudfront-logs"
    }
  }

  # 証明書設定（staging環境ではデフォルト証明書を使用）
  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
  }

  # 制限設定
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # タグ設定
  tags = merge(var.tags, {
    Name    = "CloudFront-Distribution-${var.s3_bucket_id}"
    Purpose = "Static Website CDN"
  })


}

# CloudFrontキャッシュポリシー（オプション）
resource "aws_cloudfront_cache_policy" "main" {
  name        = "Custom-CachingOptimized"
  comment     = "Optimized caching policy for static content"
  default_ttl = var.default_ttl
  max_ttl     = var.max_ttl
  min_ttl     = var.min_ttl

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

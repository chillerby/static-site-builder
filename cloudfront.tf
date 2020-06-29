locals {
  s3_origin_id = "S3-Website-${aws_s3_bucket.static_site.bucket_regional_domain_name}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  provider    = aws.use1
  origin {
    domain_name          = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id            = local.s3_origin_id
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 5
      origin_read_timeout      = 30
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Fronting static site"
  default_root_object = "index.html"
  
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = [ var.site_address ]

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.site_cert.arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method       = "sni-only"
  }

  price_class = "PriceClass_100"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id   = "s3-static-site"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Fronting static site"
  default_root_object = "index.html"

  aliases = [ var.site_address ]

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.site_cert.arn
  }
}

resource "aws_acm_certificate" "site_cert" {
  domain_name = var.domain_name
  validation_method = "DNS"
}

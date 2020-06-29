resource "aws_route53_zone" "domain" {
  count = var.create_domain_zone ? 1 : 0
  name  = var.domain
}

data "aws_route53_zone" "domain" {
  count = var.create_domain_zone ? 0 : 1
  name  = var.domain
}

resource "aws_route53_record" "site" {
  zone_id = aws_route53_zone.domain[0].zone_id
  name    = var.site_address
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

## CERTIFICATE VALIDATION RECORD
resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.site_cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.site_cert.domain_validation_options.0.resource_record_type
  zone_id = var.create_domain_zone ? aws_route53_zone.domain.0.zone_id : data.aws_route53_zone.domain.0.zone_id
  records = [aws_acm_certificate.site_cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

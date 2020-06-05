resource "aws_route53_zone" "domain" {
  count = var.create_domain_zone ? 1 : 0
  name  = var.domain
}

data "aws_route53_zone" "domain" {
  count = var.create_domain_zone ? 0 : 1
  name  = var.domain
}

resource "aws_route53_record" "site" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = var.site_address
  type    = "A"
  ttl     = "300"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = var.create_domain_zone ? aws_route53_zone.domain.zone_id : data.aws_route53_zone.domain.zone_id
    evaluate_target_health = true
  }
}

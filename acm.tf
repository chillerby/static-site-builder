resource "aws_acm_certificate" "site_cert" {
  provider    = aws.use1
  domain_name = "*.${var.domain}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "site_cert" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.site_cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

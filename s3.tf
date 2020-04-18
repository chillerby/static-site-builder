resource "aws_s3_bucket" "static_site" {
  bucket = var.site_hostname
  acl    = "public-read"
  policy = templatefile("${path.module}/policies/s3_policy.json", { site_hostname = var.site_hostname} )

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = var.tags
}

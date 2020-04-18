resource "aws_lambda_function" "updateWebsite" {
  environment {
    variables = {
      GITHUB_ACCOUNT = var.github_account
      GITHUB_REPO    = var.github_repo
      TARGET_BUCKET  = aws_s3_bucket.static_site.id
    }
  }

  function_name                  = var.function_name
  handler                        = "lambda_function.lambda_handler"
  memory_size                    = "512"
  reserved_concurrent_executions = "-1"
  role                           = aws_iam_service_linked_role.lambda.arn
  runtime                        = "python3.7"
  # source_code_hash               = "XRUMSnOnfPiBmGNlxRQlv0WgPqpcYcT2ECkqyRSbX+Y="
  timeout                        = "20"
  publish                        = true

  tracing_config {
    mode = "PassThrough"
  }

  tags = var.tags
}

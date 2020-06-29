resource "aws_lambda_function" "update_website" {
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
  role                           = aws_iam_role.lambda.arn
  runtime                        = "python3.7"
  # source_code_hash               = "XRUMSnOnfPiBmGNlxRQlv0WgPqpcYcT2ECkqyRSbX+Y="
  timeout                        = "20"
  publish                        = true

  tracing_config {
    mode = "PassThrough"
  }

  tags = var.tags
}

#  resource "aws_lambda_permission" "apigw" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.update_website.function_name
#   principal     = "apigateway.amazonaws.com"

#   # The "/*/*" portion grants access from any method on any resource
#   # within the API Gateway REST API.
#   source_arn = "${aws_api_gateway_rest_api.github_listen.execution_arn}/*/*"
# }

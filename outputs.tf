output "lambda_function_name" {
  value = "${aws_lambda_function.update_website.id}"
}

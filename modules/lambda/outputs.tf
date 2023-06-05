output "lambda_visitor_arn" {
  description = "arn of visitor lambda function"
  value = aws_lambda_function.lambda_visitor.arn
}

output "lambda_slack_notification_arn" {
  description = "arn of cloud_resume_slack_notification lambda function"
  value = aws_lambda_function.lambda_slack_notification.arn
}
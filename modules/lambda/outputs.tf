output "cloud_resume_visitor_lambda_arn" {
  description = "arn of cloud_resume_visitor lambda function"
  value = aws_lambda_function.cloud_resume_visitor.arn
}

output "cloud_resume_slack_notification_lambda_arn" {
  description = "arn of cloud_resume_slack_notification lambda function"
  value = aws_lambda_function.cloud_resume_slack_notification.arn
}
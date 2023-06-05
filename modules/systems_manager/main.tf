resource "aws_ssm_parameter" "webhook" {
  name        = var.webhook_url
  description = "slackwebhookurl for notification"
  type        = "String"
  value       = "my_value"
  
}
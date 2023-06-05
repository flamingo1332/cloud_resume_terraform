variable "sns_topic_name" {
  description = "name of sns topic"
  type        = string
  default     = "cloud_resume"
}
variable "lambda_slack_notificatino_arn" {
  description = "arn of slack notification lambda"
  type        = string
}
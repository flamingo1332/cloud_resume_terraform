# s3 key
variable "s3_key_visitor_script" {
  description = "s3 key for visitor lambda script"
  type        = string
  default     = "visitor.zip"
}
variable "s3_key_slack_notification_script" {
  description = "s3 key for slack notification lambda script"
  type        = string
  default     = "slack_notification.zip"
}


# lambda name
variable "lambda_visitor_name" {
  description = "name for visitor lambda script"
  type        = string
  default     = "cloud_resume_visitor"
}

variable "lambda_slack_notification_name" {
  description = "name for notification lambda script"
  type        = string
  default     = "cloud_resume_slack_notification"
}



# bucket
variable "s3_bucket_backend" {
  description = "s3 bucket for backend code"
  type        = string
}

# iam role for lambda
variable "iam_role_lambda_arn" {
  description = "arn of iam lambda role"
  type        = string
}

# dynamodb name
variable "dynamodb_visitor_table_name" {
  description = "table name of visitor dynamodb table"
  type        = string
}
variable "dynamodb_ip_table_name" {
  description = "table name of ip dynamodb table"
  type        = string
}
variable "apigateway_execution_arn" {
  description = "execution arn of apigateway"
  type        = string
}
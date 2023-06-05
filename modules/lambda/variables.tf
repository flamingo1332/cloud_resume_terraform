
variable "lambda_visitor_script_repository_url" {
  description = "repository url for visitor lambda script"
  type        = string
  default     = "github.com/flamingo1332/cloud_resume_code/backend/visitor.py"
}

variable "lambda_slack_notification_script_repository_url" {
  description = "repository url for notification lambda script"
  type        = string
  default     = "github.com/flamingo1332/cloud_resume_code/backend/slack_notification.py"
}


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




variable "s3_bucket_backend" {
  description = "s3 bucket for backend code"
  type = string
}

variable "iam_role_lambda_arn" {
  description = "arn of iam lambda role"
  type = string
}

variable "dynamodb_visitor_table_name" {
  description = "table name of visitor dynamodb table"
  type = string
}
variable "dynamodb_ip_table_name" {
  description = "table name of ip dynamodb table"
  type = string
}
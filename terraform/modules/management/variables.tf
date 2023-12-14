variable "sns_topic_arn" {
  description="arn for sns topic"
  type = string
}

variable "lambda_visitor_arn" {
  description="arn for visitor lambda"
  type = string
}
variable "apigateway_arn" {
  description="arn for apigateway"
  type = string
}



variable "cloudwatch_alarm_lambda_error_name" {
  description="name of cloudwatch alarm for lambda error"
  type = string
  default = "cloud_resume_lambda_error"
}
variable "cloudwatch_alarm_lambda_error_threshold" {
  description="threshold of cloudwatch alarm for lambda error"
  type = number
  default = 5
}
variable "cloudwatch_alarm_lambda_error_statistic" {
  description="statistic of cloudwatch alarm for lambda error"
  type = string
  default = "Average"
}


variable "cloudwatch_alarm_lambda_invocation_name" {
  description="name of cloudwatch alarm for lambda invocation"
  type = string
  default = "cloud_resume_lambda_invocation"
}

variable "cloudwatch_alarm_lambda_invocation_threshold" {
  description="threshold of cloudwatch alarm for lambda invocation"
  type = number
  default = 50
}
variable "cloudwatch_alarm_lambda_invocation_statistic" {
  description="statistic of cloudwatch alarm for lambda invocation"
  type = string
  default = "Average"
}


variable "cloudwatch_alarm_apigateway_latency_name" {
  description="name of cloudwatch alarm for apigateway latency"
  type = string
  default = "cloud_resume_APIgateway_latency"
}
variable "cloudwatch_alarm_apigateway_latency_threshold" {
  description="threshold of cloudwatch alarm for apigateway_latency"
  type = number
  default = 50
}
#  -----------------------------------------




variable "visitor_table_name" {
  description = "Name of the visitor table"
  type        = string
  default     = "cloud_resume_visitor"
}

variable "ip_table_name" {
  description = "Name of the ip table"
  type        = string
  default     = "cloud_resume_ip"
}



#  ------------------------------------------


variable "s3_bucket_name_frontend" {
  description = "s3 bucket name for frontend"
  type        = string
  default     = "ksw29555-cloud-resume-frontend"
}


variable "s3_bucket_name_backend" {
  description = "s3 bucket name for backend"
  type        = string
  default     = "ksw29555-cloud-resume-backend"
}


variable "s3_bucket_policy_frontend" {
  description = "s3 bucket policy for frontend"
  type        = string
  default     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::ksw29555-cloud-resume-frontend/*"
        }
    ]
}
EOF
}


variable "index_document" {
  description = "index_document for backend"
  type        = string
  default     = "index.html"
}

#  -----------------------------------------



variable "webhook_url" {
  description = "webhookurl "
  type        = string
  default     = "cloud_resume_slackwebhookurl"
}

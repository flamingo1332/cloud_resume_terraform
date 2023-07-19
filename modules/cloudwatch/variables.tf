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
variable "apigateway_stage_arn" {
  description="arn for apigateway stage"
  type = string
}


variable "cloudwatch_alarm_lambda_error_name" {
  description="name of cloudwatch alarm for lambda error"
  type = string
  default = "cloud_resume_lambda_error"
}
variable "cloudwatch_alarm_lambda_invocation_name" {
  description="name of cloudwatch alarm for lambda invocation"
  type = string
  default = "cloud_resume_lambda_invocation"
}
variable "cloudwatch_alarm_apigateway_latency_name" {
  description="name of cloudwatch alarm for apigateway latency"
  type = string
  default = "cloud_resume_APIgateway_latency"
}
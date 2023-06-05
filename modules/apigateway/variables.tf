variable "apigateway_name" {
  description = "Name of the apigateway"
  type        = string
  default     = "cloud_resume_api"
}


variable "apigateway_stage_name" {
  description = "Name of the apigateway stage"
  type        = string
  default     = "cloud_resume_stage"
}


variable "apigateway_route_key" {
  description = "key of the apigateway route"
  type        = string
  default     = "PUT /countVisitor"
}


variable "lambda_visitor_arn" {
  description = "arn of visitor lambda function"
  type        = string
}
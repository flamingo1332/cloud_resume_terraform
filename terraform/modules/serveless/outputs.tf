output "lambda_visitor_arn" {
  description = "arn of visitor lambda function"
  value       = aws_lambda_function.lambda_visitor.arn
}



output "apigateway_arn" {
  description = "arn of apigateway"
  value       = aws_apigatewayv2_api.apigateway.arn
}

output "apigateway_stage_arn" {
  description = "arn of apigateway stage"
  value       = aws_apigatewayv2_stage.apigateway_stage.arn
}




output "sns_topic_arn" {
  description = "arn of sns topic"
  value       = aws_sns_topic.sns_topic.arn
}
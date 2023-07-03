output "apigateway_arn" {
  description = "arn of apigateway"
  value       = aws_apigatewayv2_api.apigateway.arn
}

output "apigateway_execution_arn" {
  description = "execution arn of apigateway"
  value       = aws_apigatewayv2_api.apigateway.execution_arn
}

output "apigateway_stage_arn" {
  description = "arn of apigateway stage"
  value       = aws_apigatewayv2_stage.apigateway_stage.arn
}


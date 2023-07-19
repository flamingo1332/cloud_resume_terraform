resource "aws_apigatewayv2_api" "apigateway" {
  name          = var.apigateway_name
  protocol_type = "HTTP"
  description   = "API Gateway for Cloud Resume"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["*"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_stage" "apigateway_stage" {
  api_id      = aws_apigatewayv2_api.apigateway.id
  name        = var.apigateway_stage_name
  auto_deploy = true
  
}

resource "aws_apigatewayv2_integration" "apigateway_lambda_integration" {
  api_id             = aws_apigatewayv2_api.apigateway.id
  integration_type   = "AWS_PROXY"

  payload_format_version = "2.0"
  integration_uri    = var.lambda_visitor_arn
  integration_method = "POST"
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "apigateway_route" {
  api_id    = aws_apigatewayv2_api.apigateway.id
  route_key = var.apigateway_route_key

  target = "integrations/${aws_apigatewayv2_integration.apigateway_lambda_integration.id}"
}
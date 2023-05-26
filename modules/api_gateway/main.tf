resource "aws_apigatewayv2_api" "cloud_resume_api" {
  name          = "cloud_resume_api"
  protocol_type = "HTTP"
  description   = "API Gateway for Cloud Resume"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_stage" "cloud_resume_stage" {
  api_id      = aws_apigatewayv2_api.cloud_resume_api.id
  name        = "cloud_resume_stage"
  auto_deploy = true
  
}

resource "aws_apigatewayv2_integration" "cloud_resume_visitor_integration" {
  api_id             = aws_apigatewayv2_api.cloud_resume_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.cloud_resume_visitor.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "cloud_resume_route" {
  api_id    = aws_apigatewayv2_api.cloud_resume_api.id
  route_key = "PUT /countVisitor"

  target {
    integrator_type = "AWS_PROXY"
    uri             = aws_apigatewayv2_integration.cloud_resume_visitor_integration.execution_arn
  }
}
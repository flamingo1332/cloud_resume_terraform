data "aws_s3_object" "script_visitor" {
  bucket = var.s3_bucket_backend
  key    = var.s3_key_visitor_script
}
data "aws_s3_object" "script_slack_notification" {
  bucket = var.s3_bucket_backend
  key    = var.s3_key_slack_notification_script
}


resource "aws_lambda_function" "lambda_visitor" {
  function_name = var.lambda_visitor_name
  runtime       = "python3.10"
  handler       = "visitor.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  s3_bucket     = var.s3_bucket_backend
  s3_key        = var.s3_key_visitor_script
  s3_object_version = data.aws_s3_object.script_visitor.version_id

  environment {
    variables = {
      table_visitor = var.dynamodb_visitor_table_name
      table_ip      = var.dynamodb_ip_table_name
    }
  }
}

resource "aws_lambda_function" "lambda_slack_notification" {
  function_name = var.lambda_slack_notification_name
  runtime       = "python3.10"
  handler       = "slack_notification.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  s3_bucket     = var.s3_bucket_backend
  s3_key        = var.s3_key_slack_notification_script
  s3_object_version = data.aws_s3_object.script_slack_notification.version_id
}


# api gateway integration
resource "aws_lambda_permission" "apigateway_lambda_integration" {
  statement_id  = "AllowMyAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_visitor_name
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${aws_apigatewayv2_api.apigateway.execution_arn}/*"
}



resource "aws_iam_role" "lambda_role" {
  name = "LambdaRoleForCloudResume"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "dynamodb_read_write" {
  name        = "DynamoDBReadWriteAccess"
  description = "Policy for allowing read and write access to DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:BatchGetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchWriteItem"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.dynamodb_read_write.arn
}


resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}



# ------------------------------------------------------------


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
  integration_uri    = aws_lambda_function.lambda_visitor.arn
  integration_method = "POST"
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "apigateway_route" {
  api_id    = aws_apigatewayv2_api.apigateway.id
  route_key = var.apigateway_route_key

  target = "integrations/${aws_apigatewayv2_integration.apigateway_lambda_integration.id}"
}


# ------------------------------------------------------------



resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
  fifo_topic = false
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.lambda_slack_notification.arn
}
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
  role          = var.iam_role_lambda_arn
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
  role          = var.iam_role_lambda_arn
  s3_bucket     = var.s3_bucket_backend
  s3_key        = var.s3_key_slack_notification_script
  s3_object_version = data.aws_s3_object.script_slack_notification.version_id


}




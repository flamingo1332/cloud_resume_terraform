
resource "aws_lambda_function" "cloud_resume_visitor" {
  function_name    = "cloud_resume_visitor"
  role             = aws_iam_role.lambda_role.arn
  handler          = "visitor.lambda_handler"
  runtime          = "python3.10"
  architecture     = "arm64"
  source_code_hash = filebase64sha256("github.com/flamingo1332/cloud_resume_code/backend/visitor.py")
  environment {
    variables = {
      table_visitor = "cloud_resume_visitor"
      table_ip = "cloud_resume_ip"
    }
  }
}



resource "aws_lambda_function" "cloud_resume_slack_notification" {
  function_name    = "cloud_resume_slack_notification"
  role             = aws_iam_role.lambda_role.arn
  handler          = "slack_notification.lambda_handler"
  runtime          = "python3.10"
  architecture     = "arm64"
  source_code_hash = filebase64sha256("github.com/flamingo1332/cloud_resume_code/backend/slack_notification.py")
}
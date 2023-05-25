data "terraform_remote_state" "iam" {
  backend = "local"

  config = {
    path = "../outputs/iam.tf"
  }
}


resource "aws_lambda_function" "cloud_resume_visitor" {
  function_name = "cloud_resume_visitor"
  role          = data.terraform_remote_state.iam.outputs.iam_role_arn
  handler       = "visitor.lambda_handler"
  runtime       = "python3.10"
  filename      = "visitor.py"
  source_code_hash = filebase64sha256("visitor.py")

  environment {
    variables = {
      table_name = "cloud_resume_visitor"
    }
  }
}

resource "aws_lambda_function" "cloud_resume_slack_notification" {
  function_name = "cloud_resume_slack_notification"
  role          = aws_iam_role.lambda_role.arn
  handler       = "slack.lambda_handler"
  runtime       = "python3.10"
  filename      = "slack.py"
  source_code_hash = filebase64sha256("slack.py")
}
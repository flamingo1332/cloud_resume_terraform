output "lambda_role_arn" {
  description = "arn of role for lambda function"
  value = aws_iam_role.lambda_role.arn
}
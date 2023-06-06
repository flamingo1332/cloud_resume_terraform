output "lambda_role_arn" {
  description = "arn of role for lambda function"
  value       = module.iam.iam_role_lambda_arn
}

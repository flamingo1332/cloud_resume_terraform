output "terraform_backend_bucket_name" {
  description = "terraform backend s3 bucket name"
  value = aws_s3_bucket.terraform_backend_bucket.bucket
}

output "terraform_backend_lock_name" {
  description = "terraform backend lock table name"
  value = aws_dynamodb_table.terraform_backend_lock.name
}
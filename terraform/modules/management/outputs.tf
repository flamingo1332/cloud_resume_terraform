output "dynamodb_visitor_table_name" {
  description = "dynamodb visitor table name"
  value = aws_dynamodb_table.visitor_table.name
}

output "dynamodb_ip_table_name" {
  description = "dynamodb ip table name"
  value = aws_dynamodb_table.ip_table.name
}



output "s3_bucket_frontend" {
  description = "name of s3 frontend bucket"
  value       = aws_s3_bucket.frontend_bucket.bucket
}

output "s3_bucket_backend" {
  description = "name of s3 backend bucket"
  value       = aws_s3_bucket.backend_bucket.bucket
}


output "s3_bucket_frontend_regional_domain_name" {
  description = "regional domain name of s3 frontend bucket"
  value       = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
}


output "s3_bucket_frontend_id" {
  description = "id of s3 frontend bucket"
  value       = aws_s3_bucket.frontend_bucket.id
}




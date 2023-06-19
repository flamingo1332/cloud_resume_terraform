output "s3_bucket_frontend" {
  description = "name of s3 frontend bucket"
  value       = aws_s3_bucket.frontend_bucket.bucket
}

output "s3_bucket_backend" {
  description = "name of s3 backend bucket"
  value       = aws_s3_bucket.backend_bucket.bucket
}


output "s3_bucket_frontend_website_endpoint" {
  description = "website endpoint of s3 frontend bucket"
  value       = aws_s3_bucket.frontend_bucket.website_endpoint
}


output "s3_bucket_frontend_id" {
  description = "id of s3 frontend bucket"
  value       = aws_s3_bucket.frontend_bucket.id
}
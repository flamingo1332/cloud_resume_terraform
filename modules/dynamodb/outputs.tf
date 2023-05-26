output "cloud_resume_visitor_table_name" {
  description = "visitor table name"
  value = aws_dynamodb_table.cloud_resume_visitor.name
}

output "cloud_resume_ip_table_name" {
  description = "ip table name"
  value = aws_dynamodb_table.cloud_resume_ip.name
}
output "dynamodb_visitor_table_name" {
  description = "dynamodb visitor table name"
  value = aws_dynamodb_table.visitor_table.name
}

output "dynamodb_ip_table_name" {
  description = "dynamodb ip table name"
  value = aws_dynamodb_table.ip_table.name
}
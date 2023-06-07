resource "aws_dynamodb_table" "visitor_table" {
  name         = var.visitor_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "visitor"
  attribute {
    name = "visitor"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = false
  }

  tags = {
    Name = "CloudResumeVisitor"
  }
}


resource "aws_dynamodb_table_item" "visitor_table_initial_item" {
  table_name = aws_dynamodb_table.visitor_table.name
  hash_key   = aws_dynamodb_table.visitor_table.hash_key
  item = <<ITEM
  {
    "visitor": {"S": "visitor"},
    "count": {"N": "0"}
  }
  ITEM
}


resource "aws_dynamodb_table" "ip_table" {
  name         = var.ip_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ip"
  
  attribute {
    name = "ip"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  tags = {
    Name = "CloudResumeIP"
  }
}
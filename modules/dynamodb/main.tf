# 1
resource "aws_dynamodb_table" "cloud_resume_visitor" {
  name         = "cloud_resume_visitor"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "pk"
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

# prepopulate
resource "aws_dynamodb_table_item" "visitor_count_initial_item" {
  table_name = aws_dynamodb_table.visitor_count.name
  hash_key   = "pk"
  range_key  = ""

  item = {
    pk    = "visitor"
    value = 0
  }
}



# 2
resource "aws_dynamodb_table" "cloud_resume_ip" {
  name         = "cloud_resume_ip"
  billing_mode = "PAY_PER_REQUEST"

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
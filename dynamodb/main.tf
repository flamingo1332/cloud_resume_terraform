resource "aws_dynamodb_table" "visitor_count" {
  name           = "cloud_resume_visitor"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "pk"
    type = "S"
  }
  hash_key = "pk"

  ttl {
    attribute_name = "expiration_time"
    enabled        = false
  }

  tags = {
    Name = "Cloud Resume Visitor Count"
  }
}


resource "aws_dynamodb_table_item" "visitor_count_initial_item" {
  table_name = aws_dynamodb_table.visitor_count.name
  hash_key   = "pk"
  range_key  = ""

  item = {
    pk    = "visitor"
    value = 0
  }
}

resource "aws_dynamodb_table" "ip_storage" {
  name           = "cloud_resume_ip"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "ip"
    type = "S"
  }

  hash_key = "ip"
  
  ttl {
    attribute_name = "expiration_time"
    enabled        = true
  }

  tags = {
    Name = "Cloud Resume IP Storage"
  }
}




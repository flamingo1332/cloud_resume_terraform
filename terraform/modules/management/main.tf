resource "aws_cloudwatch_metric_alarm" "lambda_error" {
  alarm_name          = var.cloudwatch_alarm_lambda_error_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 86400  # 24 hours
  statistic           = var.cloudwatch_alarm_lambda_error_statistic
  threshold           = var.cloudwatch_alarm_lambda_error_threshold
  alarm_description   = "Alarm triggered when Lambda errors are greater than 5"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
  FunctionArn = var.lambda_visitor_arn
}
}

resource "aws_cloudwatch_metric_alarm" "lambda_invocation" {
  alarm_name          = var.cloudwatch_alarm_lambda_invocation_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  period              = 86400  # 24 hours
  statistic           = var.cloudwatch_alarm_lambda_invocation_statistic
  threshold           = var.cloudwatch_alarm_lambda_invocation_threshold
  alarm_description   = "Alarm triggered when Lambda invocations are greater than 50"
  alarm_actions       = [var.sns_topic_arn]
  dimensions = {
  FunctionArn = var.lambda_visitor_arn
}
}

resource "aws_cloudwatch_metric_alarm" "APIgateway_latency" {
  alarm_name          = var.cloudwatch_alarm_apigateway_latency_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  # metric_name         = "Latency"
  # namespace           = "AgWS/ApiGateway"
  # period              = 86400  # 24 hours
  # statistic           = "Averae"
  threshold           = var.cloudwatch_alarm_apigateway_latency_threshold
  alarm_description   = "Alarm triggered when API Gateway latency is greater than 50"
  alarm_actions       = [var.sns_topic_arn]

  metric_query {
    id        = "m1"
    metric {
      metric_name = "Latency"
      period = 86400
      stat = "Average"
      namespace           = "AWS/ApiGateway"
      dimensions = {
        ApiGateway = var.apigateway_arn
      }
    }
    return_data = true
  }

}


#  ---------------------------------


resource "aws_dynamodb_table" "visitor_table" {
  name         = var.visitor_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "visitor"
  attribute {
    name = "visitor"
    type = "S"
  }
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
}


#  --------------------------------



# frontend bucket
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.s3_bucket_name_frontend

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_ownership_controls" "frontend_bucket_controls" {
  bucket = aws_s3_bucket.frontend_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend_bucket_control_access" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "frontend_bucket_versioning" {
  bucket = aws_s3_bucket.frontend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "frontend_bucket_sse" {
  bucket = aws_s3_bucket.frontend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}


# frontend static website hosting
resource "aws_s3_bucket_website_configuration" "frontend_bucket_website" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.index_document
  }
}

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = var.s3_bucket_policy_frontend
  
}






# backend bucket
resource "aws_s3_bucket" "backend_bucket" {
  bucket = var.s3_bucket_name_backend

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_s3_bucket_ownership_controls" "backend_bucket_controls" {
  bucket = aws_s3_bucket.backend_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "backend_bucket_control_access" {
  bucket = aws_s3_bucket.backend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "backend_bucket_versioning" {
  bucket = aws_s3_bucket.backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backend_bucket_sse" {
  bucket = aws_s3_bucket.backend_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}





#  ---------------------------------------------


resource "aws_ssm_parameter" "webhook" {
  name        = "cloud_resume_slackwebhookurl"
  description = "slackwebhookurl for notification"
  type        = "String"
  value       = var.webhook_url
  overwrite   = true
}
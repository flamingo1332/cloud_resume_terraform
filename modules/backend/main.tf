
# s3 bucket for terraform backend
resource "aws_s3_bucket" "terraform_backend_bucket" {
  bucket = var.s3_bucket_name_terraform_backend

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_s3_bucket_versioning" "terraform_backend_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_backend_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}


# dynamodb for state lock
resource "aws_dynamodb_table" "terraform_backend_lock" {
  name           = var.dynamodb_name_terraform_backend_lock
  billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  key {
    attribute_name = "LockID"
    type           = "HASH"
  }

  server_side_encryption {
    enabled = true
  }
}
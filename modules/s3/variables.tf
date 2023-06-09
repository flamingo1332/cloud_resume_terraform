variable "s3_bucket_name_frontend" {
  description = "s3 bucket name for frontend"
  type        = string
  default     = "ksw29555-cloud-resume-frontend"
}


variable "s3_bucket_name_backend" {
  description = "s3 bucket name for backend"
  type        = string
  default     = "ksw29555-cloud-resume-backend"
}


variable "s3_bucket_policy_frontend" {
  description = "s3 bucket policy for frontend"
  type        = string
  default     = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::ksw29555-cloud-resume-frontend/*"
        }
    ]
}
EOF
}

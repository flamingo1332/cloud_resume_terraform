variable "domain_name" {
  description = "domain name"
  type        = string
}

variable "s3_bucket_frontend_website_endpoint" {
  description = "website endpoint of s3 frontend bucket"
  type = string
}

variable "s3_bucket_frontend_id" {
  description = "id of s3 frontend bucket"
  type = string
}

variable "s3_bucket_frontend_origin_id" {
  description = "origin id of s3 frontend bucket"
  type = string
  default = "CloudResumeS3Origin"
}

variable "acm_certificate_arn" {
  description = "arn of acm certificate"
  type = string
}
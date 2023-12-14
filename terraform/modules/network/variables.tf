variable "domain_name" {
  description = "domain name"
  type = string
  default = "example.com"
}


variable "validation_method" {
  description = "acm validation_method"
  type = string
  default = "DNS"
}

#  -------------------------------

variable "s3_bucket_frontend_regional_domain_name" {
  description = "regional domain name of s3 frontend bucket"
  type = string
}

variable "s3_bucket_frontend_id" {
  description = "id of s3 frontend bucket"
  type = string
}

variable "default_root_object"{
  description = "default root obj"
  type = string
  default = "index.html"
}


variable "price_class" {
  description = "price class"
  type = string
  default = "PriceClass_200"
}




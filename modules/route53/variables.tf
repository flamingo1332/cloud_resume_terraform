variable "domain_name" {
  description = "domain name"
  type = string
}

variable "cloudfront_s3_distribution_domain_name"{
    description = "domain name for cloudfront distribution"
    type = string
}

variable "cloudfront_s3_distribution_hosted_zone_id"{
    description = "hosted_zone_id for cloudfront distribution"
    type = string
}
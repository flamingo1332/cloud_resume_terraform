output "cloudfront_s3_distribution_domain_name"{
    description = "domain name for cloudfront distribution"
    value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_s3_distribution_hosted_zone_id"{
    description = "hosted_zone_id for cloudfront distribution"
    value = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
}
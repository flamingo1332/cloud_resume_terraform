resource "aws_acm_certificate" "acm_certification" {
  provider          = aws.use1
  domain_name       = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method = var.validation_method
}

data "aws_route53_zone" "hosted_zone" {
  name         = var.domain_name
  private_zone = false
}


resource "aws_route53_record" "record" {
  for_each = {
    for dvo in aws_acm_certificate.acm_certification.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = aws_route53_zone.hosted_zone.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = each.value.zone_id
}


resource "aws_acm_certificate_validation" "validation" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.acm_certification.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
}


# ---------------------------------------------------------------


resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = var.s3_bucket_frontend_regional_domain_name
    origin_id                = "S3-${var.s3_bucket_frontend_id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object

  aliases = [ var.domain_name , "www.${var.domain_name}"]

  price_class = "PriceClass_200"

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.acm_certification.arn
    ssl_support_method  = "sni-only"
  }
  

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "JP", "KR"]
    }
  }

# react
  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 5
    response_code         = "200"
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 5
    response_code         = "200"
    response_page_path    = "/index.html"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["HEAD", "GET"]
    target_origin_id = "S3-${var.s3_bucket_frontend_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
}



# ---------------------------------------------------------------


resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}


# data "aws_route53_zone" "zone_data"{
#   name = aws_route53_zone.hosted_zone.name
# }

# Route 53 alias record (domain_name)
resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = var.domain_name
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_www" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}


# registered domain
# data "aws_route53domains_registered_domain" "regiestered_domain" {
#   domain_name = var.domain_name
# }

resource "aws_route53domains_registered_domain" "managed_regiestered_domain" {
  domain_name = var.domain_name
  auto_renew = false

  admin_contact {
    address_line_1 = "gg"
    address_line_2 = "b"
    city           = "gy"
    contact_type   = "PERSON"
    country_code   = "KR"
    email          = "ksw29555@gmail.com"
    first_name     = "sn"
    last_name      = "k"
    phone_number   = "+82.1012341234"
    zip_code       = "10417"
  }


  name_server {
    name = aws_route53_zone.hosted_zone.name_servers[0]
  }
  name_server {
    name = aws_route53_zone.hosted_zone.name_servers[1]
  }
  name_server {
    name = aws_route53_zone.hosted_zone.name_servers[2]
  }
  name_server {
    name = aws_route53_zone.hosted_zone.name_servers[3]
  }
}


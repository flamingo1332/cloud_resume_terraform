
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
    name                   = var.cloudfront_s3_distribution_domain_name
    zone_id                = var.cloudfront_s3_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_www" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_s3_distribution_domain_name
    zone_id                = var.cloudfront_s3_distribution_hosted_zone_id
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
    address_line_1 = "242 Ilsan-ro, Ilsandong-gu, Goyang-si, Gyeonggi-do"
    address_line_2 = "baek-ma 607 - 401"
    city           = "goyang"
    contact_type   = "PERSON"
    country_code   = "KR"
    email          = "ksw29555@gmail.com"
    first_name     = "sn"
    last_name      = "k"
    phone_number   = "+82.1036355184"
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

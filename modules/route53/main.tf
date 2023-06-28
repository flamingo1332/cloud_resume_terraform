
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

locals {
  name_servers_map = { for idx, ns in aws_route53_zone.hosted_zone.name_servers : idx => ns }
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

  name_server {
    name = aws_route53_zone.hosted_zone.primary_name_server
  }

}

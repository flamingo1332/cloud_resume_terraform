# hosted zone
data "aws_route53_zone" "zone" {
  name = var.domain_name
}

resource "aws_route53_zone" "managed_zone" {
  name = var.domain_name
}


# Route 53 alias record (domain_name)
resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.managed_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_s3_distribution_domain_name
    zone_id                = var.cloudfront_s3_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_www" {
  zone_id = aws_route53_zone.managed_zone.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.cloudfront_s3_distribution_domain_name
    zone_id                = var.cloudfront_s3_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}


# registered domain
data "aws_route53domains_registered_domain" "regiestered_domain" {
  domain_name = var.domain_name
}

resource "aws_route53domains_registered_domain" "managed_regiestered_domain" {
  domain_name = var.domain_name
}



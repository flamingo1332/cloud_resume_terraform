
resource "aws_acm_certificate" "acm_certification" {
  domain_name       = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method = "DNS"
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
      zone_id = data.aws_route53_zone.hosted_zone.zone_id
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
  certificate_arn         = aws_acm_certificate.acm_certification.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
}

data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "Terraform-Route53-Record" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = data.aws_route53_zone.hosted_zone.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.Terraform-CDN.domain_name
    zone_id                = aws_cloudfront_distribution.Terraform-CDN.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "Terraform-Route53-Record-WWW" {
  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = var.www_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.Terraform-CDN.domain_name
    zone_id                = aws_cloudfront_distribution.Terraform-CDN.hosted_zone_id
    evaluate_target_health = true
  }
}

output "lb_dns" {
  value = aws_lb.Terraform-Application-Lb.dns_name
}

output "cdn_dns" {
  value = aws_cloudfront_distribution.Terraform-CDN.domain_name
}

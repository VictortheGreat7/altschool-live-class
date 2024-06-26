# modules/cloudfront/outputs.tf

output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.this.hosted_zone_id
}

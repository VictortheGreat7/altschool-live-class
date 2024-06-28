# modules/cloudfront/outputs.tf

output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.this.iam_arn
}
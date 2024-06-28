# root/outputs.tf

output "bucket_name" {
  value = module.s3_bucket.bucket_name
}

output "cloudfront_distribution_domain" {
  value = module.cloudfront.cloudfront_distribution_domain
}

# output "api_invocation_url" {
#   value = module.api_gateway.api_endpoint
# }

# output "cloudfront_hosted_zone_id" {
#   value = module.cloudfront.cloudfront_distribution_hosted_zone_id
# }

# output "certificate_arn" {
#   value = module.acm.certificate_arn
# }

# output "route53_zone_id" {
#   value = module.route53.route53_zone_id
# }

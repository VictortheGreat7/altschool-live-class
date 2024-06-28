# root/outputs.tf

output "cloudfront_distribution_domain" {
  value = module.cloudfront.cloudfront_distribution_domain
}

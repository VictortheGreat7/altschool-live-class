# modules/api_gateway/ouputs.tf

# Output the API endpoint
output "api_endpoint" {
  value = "${aws_api_gateway_stage.wonder-prod.invoke_url}/static"
}

# Output the API ID for later use
output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}

# # Output the CloudFront distribution domain name
# output "cloudfront_distribution_domain_name" {
#   value = aws_api_gateway_domain_name.custom_domain.cloudfront_domain_name
# }

# # Output the CloudFront distribution hosted zone ID
# output "cloudfront_distribution_hosted_zone_id" {
#   value = aws_api_gateway_domain_name.custom_domain.cloudfront_zone_id
# }

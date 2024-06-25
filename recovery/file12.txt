# modules/api_gateway/ouputs.tf

# Output the API endpoint
output "api_endpoint" {
  value = "${aws_api_gateway_stage.prod.invoke_url}/static"
}

# Output the API ID for later use
output "api_id" {
  value = aws_api_gateway_rest_api.api.id
}
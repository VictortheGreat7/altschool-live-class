# modules/api_gateway/api_gateway_config.tf

# Create a deployment for the API
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_rest_api.api, aws_api_gateway_resource.root, aws_api_gateway_method.static_get, aws_api_gateway_integration.cloudfront_get, aws_api_gateway_method_response.static_get_response_200, aws_api_gateway_integration_response.static_get_integration_response_200]
  rest_api_id = aws_api_gateway_rest_api.api.id
}

# Create a stage for the deployment
resource "aws_api_gateway_stage" "wonder-prod" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name

  description = "Production stage"
}

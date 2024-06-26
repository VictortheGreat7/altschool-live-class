# modules/api_gateway/api_gateway_config.tf

# Create a deployment for the API
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [aws_api_gateway_integration.s3_get]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name
}

# Create a stage for the deployment
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name

  variables = {
    "lambdaAlias" = var.stage_name
  }

  description = "Production stage"
}

# modules/api_gateway/api_gateway_config.tf

# Create an API Gateway Deployment and Stage
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = var.stage_name

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_api_gateway_integration.cloudfront_get]
}

resource "aws_api_gateway_stage" "api_stage" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = aws_api_gateway_deployment.api_deployment.stage_name
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}

# Create a Usage Plan
resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "StaticWebsiteUsagePlan"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api_stage.stage_name
  }

  throttle_settings {
    burst_limit = 100
    rate_limit  = 50
  }
}
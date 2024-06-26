# modules/api_gateway/variables.tf

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "stage_name" {
  description = "The stage name for the API Gateway deployment"
  type        = string
}

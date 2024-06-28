# modules/api_gateway/variables.tf

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "stage_name" {
  description = "The stage name for the API Gateway deployment"
  type        = string
}

variable "cloudfront_domain_name" {
  type = string
}

# variable "custom_domain_name" {
#   type = string
# }

# variable "acm_certificate_arn" {
#   type = string
# }

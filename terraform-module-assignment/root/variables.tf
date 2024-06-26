# root/variables.tf

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "The custom domain name for the CloudFront distribution"
  type        = string
  default     = "mywonder.works"
}

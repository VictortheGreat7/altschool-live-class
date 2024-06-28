# modules/route53/variables.tf

variable "domain_name" {
  description = "The custom domain name for the CloudFront distribution"
  type        = string
}

variable "subdomain" {
  description = "The custom domain name for the CloudFront distribution"
  type        = string
}

variable "cloudfront_domain_name" {
  type = string
}

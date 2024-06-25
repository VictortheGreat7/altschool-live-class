# modules/acm/variables.tf

variable "domain_name" {
  description = "The domain name for the certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID"
  type        = string
}

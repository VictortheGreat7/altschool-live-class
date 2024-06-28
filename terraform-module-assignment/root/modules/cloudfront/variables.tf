# modules/cloudfront/variables.tf

variable "s3_bucket_origin_id" {
  description = "The S3 bucket origin ID for the CloudFront distribution"
  type        = string
}

variable "s3_bucket_domain_name" {
  description = "The S3 bucket domain name for the CloudFront distribution"
  type        = string
}

variable "domain_name" {
  description = "The custom domain name for the CloudFront distribution"
  type        = string
}

variable "subdomain" {
  description = "The custom domain name for the CloudFront distribution"
  type        = string
}

variable "default_root_object" {
  description = "The default root object for the CloudFront distribution"
  type        = string
}

variable "validatation_complete" {
  description = "The validation complete flag for the CloudFront distribution"
  type        = any
}


variable "certificate_arn" {
  description = "The ARN of the ACM certificate for the CloudFront distribution"
  type        = string
}

# variable "invoke_url" {
#   description = "The invoke URL for the CloudFront distribution"
#   type        = string
# }

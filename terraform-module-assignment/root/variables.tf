# root/variables.tf

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "my-tinubu-bucket"
}

variable "default_root" {
  description = "The default root object for the CloudFront distribution"
  type        = string
  default     = "index.html"
}

variable "domain_name" {
  description = "The custom domain name for the CloudFront distribution"
  type        = string
  default     = "mywonder.works"
}

variable "subdomain" {
  description = "The subdomain for the CloudFront distribution"
  type        = string
  default     = "login"
}

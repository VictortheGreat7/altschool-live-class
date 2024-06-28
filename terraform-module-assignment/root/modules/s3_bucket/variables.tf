# modules/s3_bucket/variables.tf

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

# variable "origin_access_identity" {
#   description = "The origin access identity for the S3 bucket"
#   type        = string
# }

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

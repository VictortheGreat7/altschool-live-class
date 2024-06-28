# root/data.tf

# Terraform configuration file to retrieve the AWS account details of the current AWS user when terraform apply is run.

# Use the aws_caller_identity data source to get details about the AWS account of the caller.
data "aws_caller_identity" "current" {}


# data "aws_iam_policy_document" "s3_bucket_policy" {
#   statement {
#     actions   = ["s3:GetObject"]
#     resources = ["arn:aws:s3:::${module.s3_bucket.bucket_name}/*"]
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }
#   }
# }

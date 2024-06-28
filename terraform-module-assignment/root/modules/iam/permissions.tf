# modules/iam/permissions.tf

# Terraform configuration file to create an IAM role and policy for CloudFront to access an S3 bucket.

# Create an IAM role for CloudFront to assume in order to access the S3 bucket.
resource "aws_iam_role" "s3_access_role" {
  name = "cloudfront-s3-access-role" # Name of the IAM role.

  assume_role_policy = jsonencode({
    Version = "2012-10-17" # Policy version.
    Statement = [{
      Action = "sts:AssumeRole" # Allow CloudFront to assume this role.
      Effect = "Allow"          # Allow the assume role action.
      Principal = {
        Service = "cloudfront.amazonaws.com" # CloudFront service principal.
      }
    }]
  })

  max_session_duration = 43200 # Maximum session duration in seconds

}

# Create an IAM policy that grants read access to the S3 bucket.
resource "aws_iam_policy" "s3_access_policy" {
  name        = "cloudfront-s3-access-policy"            # Name of the IAM policy.
  description = "IAM policy for accessing the S3 bucket" # Description of the IAM policy.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:GetObject" # Allow the GetObject action on the S3 bucket.
      ]
      Effect = "Allow" # Allow the specified actions.
      Resource = [
        "${var.bucket_arn}",  # ARN of the S3 bucket.
        "${var.bucket_arn}/*" # ARN of all objects in the S3 bucket.
      ]
    }]
  })
}

# Attach the IAM policy to the IAM role.
resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  role       = aws_iam_role.s3_access_role.name    # Name of the IAM role created above.
  policy_arn = aws_iam_policy.s3_access_policy.arn # ARN of the IAM policy created above.
}

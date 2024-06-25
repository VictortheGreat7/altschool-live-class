# modules/iam/permissions.tf

# Example IAM role for accessing the S3 bucket
resource "aws_iam_role" "s3_access_role" {
  name = "s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Example IAM policy for the S3 bucket
resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-access-policy"
  description = "IAM policy for accessing the S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]
      Effect   = "Allow"
      Resource = [
        "${var.bucket_arn}",
        "${var.bucket_arn}/*"
      ]
    }]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

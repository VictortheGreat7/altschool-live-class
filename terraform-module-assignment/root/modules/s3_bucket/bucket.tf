# modules/s3_bucket/bucket.tf

# Terraform configuration file to create and configure an S3 bucket for hosting a static website.

# Create an S3 bucket resource.
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name # Name of the S3 bucket to be created, passed in as a variable.
}

# Configure the S3 bucket for static website hosting.
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket # Reference to the S3 bucket created above.

  index_document {
    suffix = "index.html" # The default document to return when a request is made to the root of the bucket.
  }

  error_document {
    key = "error.html" # The document to return in case of a 4XX error.
  }
}

# Define local content types for different file extensions.
locals {
  content_types = {
    ".html" = "text/html" # MIME type for HTML files.
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
    # Add more content types as needed.
  }
}

# Upload individual files to the S3 bucket.
resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.root}/website", "**") # Iterate over all files in the 'website' directory.

  bucket = aws_s3_bucket.this.bucket            # Reference to the S3 bucket created above.
  key    = each.value                           # Key (path) for the object in the S3 bucket.
  source = "${path.root}/website/${each.value}" # Path to the source file on disk.
  content_type = lookup(
    local.content_types,
    length(regexall("[.][^.]*$", each.value)) > 0 ? regexall("[.][^.]*$", each.value)[0] : "",
    "application/octet-stream" # Default content type if the file extension is not recognized.
  )
}

# Define a bucket policy to allow CloudFront to access the S3 bucket.
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.bucket # Reference to the S3 bucket created above.

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow" # Allow access to the S3 bucket.
        Principal = {
          AWS = var.origin_access_identity # Reference to the CloudFront origin access identity.
        }
        # Principal = {
        #   AWS = "arn:aws:iam::${var.account_id}:role/cloudfront-s3-access-role" # Reference to an IAM role.
        # }
        Action   = "s3:GetObject"                # Allow the GetObject action.
        Resource = "${aws_s3_bucket.this.arn}/*" # Apply the policy to all objects in the S3 bucket.
      }
    ]
  })
}

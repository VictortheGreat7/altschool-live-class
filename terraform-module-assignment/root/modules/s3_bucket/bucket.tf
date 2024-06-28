# modules/s3_bucket/bucket.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

locals {
  content_types = {
    ".html" = "text/html",
    ".css"  = "text/css",
    ".js"   = "application/javascript",
    ".png"  = "image/png",
    ".jpg"  = "image/jpeg",
    ".jpeg" = "image/jpeg",
    ".svg"  = "image/svg+xml"
    # Add more content types as needed
  }
}

# Upload individual files to S3
resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.root}/website", "**") # Assumes files are in a 'website' directory

  bucket = aws_s3_bucket.this.bucket
  key    = each.value
  source = "${path.root}/website/${each.value}"
  content_type = lookup(
    local.content_types,
    length(regexall("[.][^.]*$", each.value)) > 0 ? regexall("[.][^.]*$", each.value)[0] : "",
    "application/octet-stream"
  )
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.origin_access_identity
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

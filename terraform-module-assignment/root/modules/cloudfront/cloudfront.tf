# modules/cloudfront/cloudfront.tf

# Terraform configuration file to create a CloudFront distribution for serving content from an S3 bucket.

# Define a local variable for the ACM certificate ARN.
locals {
  certificate_arn = var.certificate_arn # ACM certificate ARN passed in as a variable.
}

# Create a CloudFront distribution.
resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.s3_bucket_domain_name # Domain name of the S3 bucket.
    origin_id   = var.s3_bucket_origin_id   # Origin ID for the S3 bucket.

    # Configuration for S3 origin access identity (commented out).
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }

    # custom_origin_config {
    #   http_port              = 80           # HTTP port for the custom origin.
    #   https_port             = 443          # HTTPS port for the custom origin.
    #   origin_protocol_policy = "https-only" # Protocol policy for the origin.
    #   origin_ssl_protocols   = ["TLSv1.2"]  # Supported SSL protocols.
    # }
  }

  # Additional origin configuration for API Gateway (commented out).
  # origin {
  #   domain_name = var.invoke_url
  #   origin_id   = "api-gateway-origin"
  #   custom_origin_config {
  #     http_port                = 80
  #     https_port               = 443
  #     origin_protocol_policy   = "https-only"
  #     origin_ssl_protocols     = ["TLSv1.2"]
  #   }
  # }

  enabled             = true                    # Enable the CloudFront distribution.
  is_ipv6_enabled     = true                    # Enable IPv6 for the distribution.
  default_root_object = var.default_root_object # Default root object for the distribution.

  aliases = ["${var.subdomain}.${var.domain_name}"] # Aliases for the distribution.

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]         # Allowed methods for the cache behavior.
    cached_methods   = ["GET", "HEAD"]         # Cached methods for the cache behavior.
    target_origin_id = var.s3_bucket_origin_id # Target origin ID for the cache behavior.

    forwarded_values {
      query_string = false # Disable forwarding query strings.

      cookies {
        forward = "none" # Disable forwarding cookies.
      }
    }

    viewer_protocol_policy = "redirect-to-https" # Redirect HTTP requests to HTTPS.
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Ordered cache behavior for assets (commented out).
  # ordered_cache_behavior {
  #   path_pattern     = "/assets/*"
  #   allowed_methods  = ["GET", "HEAD"]
  #   cached_methods   = ["GET", "HEAD"]
  #   target_origin_id = "api-gateway-origin"

  #   forwarded_values {
  #     query_string = true

  #     headers = ["Authorization"]

  #     cookies {
  #       forward = "all"
  #     }
  #   }

  #   viewer_protocol_policy = "redirect-to-https"
  #   min_ttl                = 0
  #   default_ttl            = 0
  #   max_ttl                = 0
  # }

  restrictions {
    geo_restriction {
      restriction_type = "none" # No geographic restrictions.
    }
  }

  viewer_certificate {
    acm_certificate_arn      = local.certificate_arn # ARN of the ACM certificate.
    ssl_support_method       = "sni-only"            # SSL support method.
    minimum_protocol_version = "TLSv1.2_2021"        # Minimum SSL protocol version.
  }

  depends_on = [var.validatation_complete] # Ensure the distribution depends on the ACM certificate validation completion.
}

# Create an origin access identity for CloudFront to access the S3 bucket.
resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Origin Access Identity for S3 bucket" # Comment describing the origin access identity.
}

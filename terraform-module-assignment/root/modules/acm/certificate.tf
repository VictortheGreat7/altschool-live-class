# modules/acm/certificate.tf

# Terraform configuration file to create and validate an ACM certificate using Route53 DNS validation.

# Create an ACM certificate for the specified domain.
resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name # The domain name for the ACM certificate.
  validation_method = "DNS"           # Use DNS validation for the ACM certificate.

  lifecycle {
    create_before_destroy = true # Ensure the new certificate is created before the old one is destroyed.
  }
}

# Create Route53 DNS records for validating the ACM certificate.
resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name  # DNS record name for validation.
      type   = dvo.resource_record_type  # DNS record type for validation.
      record = dvo.resource_record_value # DNS record value for validation.
    }
  }

  zone_id = var.route53_zone_id # ID of the Route53 hosted zone.
  name    = each.value.name     # DNS record name.
  type    = each.value.type     # DNS record type.
  ttl     = 60                  # Time-to-live for the DNS record, in seconds.
  records = [each.value.record] # DNS record value.
}

# Validate the ACM certificate using the Route53 DNS records.
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.this.arn                                # ARN of the ACM certificate to be validated.
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn] # List of fully qualified domain names for validation.
}

# modules/route53/route53.tf

# Terraform configuration file to set up Route53 DNS records.

# Create a Route53 hosted zone for the domain.
resource "aws_route53_zone" "this" {
  name = var.domain_name # The domain name for the hosted zone, passed in as a variable.
}

# Create a CNAME record for the login subdomain pointing to the CloudFront distribution.
resource "aws_route53_record" "login" {
  zone_id = aws_route53_zone.this.zone_id         # ID of the hosted zone created above.
  name    = "${var.subdomain}.${var.domain_name}" # The full domain name for the CNAME record.
  type    = "CNAME"                               # Record type is CNAME.
  ttl     = 60                                    # Time-to-live for the DNS record, in seconds.
  records = [var.cloudfront_domain_name]          # The domain name of the CloudFront distribution.
}

# modules/route53/route53.tf

resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "login" {
  zone_id = aws_route53_zone.this.zone_id # Replace with your hosted zone ID
  name    = "${var.subdomain}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 60
  records = [var.cloudfront_domain_name]
}
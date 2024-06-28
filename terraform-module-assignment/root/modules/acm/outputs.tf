# modules/acm/outputs.tf

output "certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "domain_validation_options" {
  value = aws_acm_certificate.this.domain_validation_options
}

output "aws_acm_certificate_validation" {
  value = aws_acm_certificate_validation.acm_certificate_validation
}
# root/main.tf

# Terraform configuration file to set up AWS infrastructure including S3 bucket, IAM roles,
# CloudFront distribution, Route53 DNS, local settings, and ACM for SSL certificates.

# Define the S3 bucket module, which creates an S3 bucket for storing static assets.
module "s3_bucket" {
  source      = "./modules/s3_bucket"                       # Path to the S3 bucket module.
  bucket_name = var.bucket_name                             # Name of the S3 bucket to be created.
  account_id  = data.aws_caller_identity.current.account_id # AWS account ID of the current user.
  origin_access_identity = module.cloudfront.origin_access_identity  # (Optional) Origin access identity for CloudFront.
}

# Define the IAM module, which sets up the necessary IAM roles and policies for accessing the S3 bucket.
module "iam" {
  source     = "./modules/iam"             # Path to the IAM module.
  bucket_arn = module.s3_bucket.bucket_arn # ARN of the S3 bucket created by the S3 bucket module.
}

# Define the CloudFront module, which creates a CloudFront distribution for the S3 bucket.
module "cloudfront" {
  source                = "./modules/cloudfront"                       # Path to the CloudFront module.
  s3_bucket_origin_id   = module.s3_bucket.origin_id                   # Origin ID of the S3 bucket.
  s3_bucket_domain_name = module.s3_bucket.bucket_regional_domain_name # Regional domain name of the S3 bucket.
  default_root_object   = var.default_root                             # Default root object for the CloudFront distribution.
  domain_name           = var.domain_name                              # Domain name for the CloudFront distribution.
  subdomain             = var.subdomain                                # Subdomain for the CloudFront distribution.
  validatation_complete = module.acm.aws_acm_certificate_validation    # Validation completion status for the ACM certificate.
  # invoke_url            = module.api_gateway.api_invoke_url  # (Optional) Invoke URL for the API Gateway.
  certificate_arn = module.acm.certificate_arn # ARN of the ACM certificate.
}

# Define the Route53 module, which sets up DNS records for the CloudFront distribution.
module "route53" {
  source                 = "./modules/route53"                              # Path to the Route53 module.
  domain_name            = var.domain_name                                  # Domain name for the DNS records.
  subdomain              = var.subdomain                                    # Subdomain for the DNS records.
  cloudfront_domain_name = module.cloudfront.cloudfront_distribution_domain # CloudFront distribution domain name.
}

# Define the local module, which configures local settings for the infrastructure.
module "local" {
  source       = "./modules/local"           # Path to the local module.
  name_servers = module.route53.name_servers # Name servers from the Route53 module.
}

# Define the ACM module, which sets up SSL/TLS certificates for the domain.
module "acm" {
  source          = "./modules/acm"                       # Path to the ACM module.
  domain_name     = "${var.subdomain}.${var.domain_name}" # Domain name for the ACM certificate.
  route53_zone_id = module.route53.route53_zone_id        # Route53 hosted zone ID.
}



# module "api_gateway" {
#   source             = "./modules/api_gateway"
#   region             = var.region
#   stage_name         = "mywonder-prod"
#   custom_domain_name = var.domain_name
#   # cloudfront_domain_name = module.cloudfront.cloudfront_distribution_domain
# }
# root/main.tf

module "s3_bucket" {
  source                 = "./modules/s3_bucket"
  bucket_name            = "my-tinubu-bucket"
  origin_access_identity = module.cloudfront.origin_access_identity
}

module "cloudfront" {
  source                = "./modules/cloudfront"
  s3_bucket_origin_id   = module.s3_bucket.origin_id
  s3_bucket_domain_name = module.s3_bucket.bucket_regional_domain_name
  default_root_object   = "index.html"
  domain_name           = var.domain_name
  subdomain             = "login"
  validatation_complete = module.acm.aws_acm_certificate_validation
  certificate_arn       = module.acm.certificate_arn
}

module "iam" {
  source      = "./modules/iam"
  bucket_arn  = module.s3_bucket.bucket_arn
  bucket_name = module.s3_bucket.bucket_name
}

# module "api_gateway" {
#   source     = "./modules/api_gateway"
#   region     = var.region
#   stage_name = "wonder-prod"
#   # custom_domain_name     = var.domain_name
#   cloudfront_domain_name = module.cloudfront.cloudfront_distribution_domain
# }

module "route53" {
  source                 = "./modules/route53"
  domain_name            = var.domain_name
  subdomain              = "login"
  cloudfront_domain_name = module.cloudfront.cloudfront_distribution_domain
}

module "local" {
  source       = "./modules/local"
  name_servers = module.route53.name_servers
}

module "acm" {
  source          = "./modules/acm"
  domain_name     = "login.${var.domain_name}"
  route53_zone_id = module.route53.route53_zone_id
}
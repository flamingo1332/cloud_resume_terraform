terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.1.0"
    }
  }

  backend "s3" {
    bucket         = "ksw29555-terraform-backend"
    key            = "terraform/main.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "cloud_resume_terraform_lock"
  }


}


provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "use1"
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# module "backend" {
#   source = "./modules/backend"
# }

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
}

# s3 bucket url
# iam role
# db name (as env variable)
module "lambda" {
  source                      = "./modules/lambda"
  s3_bucket_backend           = module.s3.s3_bucket_backend
  iam_role_lambda_arn         = module.iam.iam_role_lambda_arn
  dynamodb_visitor_table_name = module.dynamodb.dynamodb_visitor_table_name
  dynamodb_ip_table_name      = module.dynamodb.dynamodb_ip_table_name
}


# lambda arn (visitor)
module "apigateway" {
  source             = "./modules/apigateway"
  lambda_visitor_arn = module.lambda.lambda_visitor_arn

}

# lambda arn (slack_notification)
module "sns_topic" {
  source                        = "./modules/sns_topic"
  lambda_slack_notificatino_arn = module.lambda.lambda_slack_notification_arn
}

# lambda_arn(slack_notification)
# apigateway
# apigateway stage
# sns_topic_arn
module "cloudwatch" {
  source               = "./modules/cloudwatch"
  sns_topic_arn        = module.sns_topic.sns_topic_arn
  lambda_visitor_arn   = module.lambda.lambda_visitor_arn
  apigateway_arn       = module.apigateway.apigateway_arn
  apigateway_stage_arn = module.apigateway.apigateway_stage_arn
}

module "systems_manager" {
  source = "./modules/systems_manager"
}

module "acm" {
  source = "./modules/acm"
  providers = {
    aws = aws.use1
  }
  domain_name = var.domain_name
}

# s3 bucket regional domain name
# acm certificate arn
module "cloudfront" {
  source = "./modules/cloudfront"

  domain_name = var.domain_name
  s3_bucket_frontend_regional_domain_name = module.s3.s3_bucket_frontend_regional_domain_name
  s3_bucket_frontend_id = module.s3.s3_bucket_frontend_id
  acm_certificate_arn = module.acm.acm_certificate_arn
}

module "route53" {
  source = "./modules/route53"

  domain_name = var.domain_name
  cloudfront_s3_distribution_domain_name = module.cloudfront.cloudfront_s3_distribution_domain_name
  cloudfront_s3_distribution_hosted_zone_id = module.cloudfront.cloudfront_s3_distribution_hosted_zone_id
}









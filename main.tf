terraform {

  cloud {
    organization = "ksw29555_personal_project"
    hostname = "app.terraform.io"

    workspaces {
      name = "cloud_resume"
    }
  }
  required_version = ">= 1.2.0"
}




provider "aws" {  

  region = var.aws_region
  # access_key = var.secrets.AWS_ACCESS_KEY
  # secret_key = var.secrets.AWS_SECRET_KEY
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}

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
  source = "./modules/lambda"
  s3_bucket_backend = module.s3.s3_bucket_backend
  iam_role_lambda_arn = module.iam.iam_role_lambda_arn
  dynamodb_visitor_table_name = module.dynamodb.dynamodb_visitor_table_name
  dynamodb_ip_table_name = module.dynamodb.dynamodb_ip_table_name
}


# lambda arn (visitor)
module "apigateway" {
  source = "./modules/apigateway"
  lambda_visitor_arn = module.lambda.lambda_visitor_arn

}

# lambda arn (slack_notification)
module "sns_topic" {
  source = "./modules/sns_topic"
  lambda_slack_notificatino_arn = module.lambda.lambda_slack_notification_arn
}

# lambda_arn(slack_notification)
# apigateway
# apigateway stage
# sns_topic_arn
module "cloudwatch" {
  source = "./modules/cloudwatch"
  sns_topic_arn = module.sns_topic.sns_topic_arn
  lambda_visitor_arn = module.lambda.lambda_visitor_arn
  apigateway_arn = module.apigateway.apigateway_arn
  apigateway_stage_arn = module.apigateway.apigateway_stage_arn
}

module "systems_manager" {
  source = "./modules/systems_manager"
}

# module "route53" {
#   source = "./modules/route53"
# }









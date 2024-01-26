# module "terraform_state_backend" {
#   source = "cloudposse/tfstate-backend/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   version = "1.1.1"
#   name    = "ksw29555-wordpress-terraform-backend-bucket"


#   dynamodb_enabled    = true
#   dynamodb_table_name = "wordpress-terraform-backend-db"
#   read_capacity       = 1
#   write_capacity      = 1

#   terraform_backend_config_file_path = "."
#   terraform_backend_config_file_name = "backend.tf"

#   # set it true to destroy
#   force_destroy = false
# }


module "management" {
  source = "./modules/management"

  sns_topic_arn = module.serveless.sns_topic_arn

  cloudwatch_alarm_lambda_error_name      = "cloud_resume_lambda_error"
  cloudwatch_alarm_lambda_error_threshold = 5
  cloudwatch_alarm_lambda_error_statistic = "Average"

  cloudwatch_alarm_lambda_invocation_name       = "cloud_resume_lambda_invocation"
  cloudwatch_alarm_lambda_invocation_threshold  = 50
  cloudwatch_alarm_lambda_invocation_statistic  = "Average"
  cloudwatch_alarm_apigateway_latency_name      = "cloud_resume_APIgateway_latency"
  cloudwatch_alarm_apigateway_latency_threshold = 50
  apigateway_arn                                = module.serveless.apigateway_arn
  lambda_visitor_arn                            = module.serveless.lambda_visitor_arn

  index_document = "index.html"
  webhook_url    = "webhook_url"
}




module "network" {
  source = "./modules/network"

  providers = {
    aws      = aws
    aws.use1 = aws.use1
  }

  domain_name       = var.domain_name
  validation_method = "DNS"

  s3_bucket_frontend_regional_domain_name = module.management.s3_bucket_frontend_regional_domain_name
  s3_bucket_frontend_id                   = module.management.s3_bucket_frontend_id

  default_root_object = "index.html"
  price_class         = "PriceClass_200"


}


module "serveless" {
  source                           = "./modules/serveless"
  s3_bucket_backend                = module.management.s3_bucket_backend
  s3_key_visitor_script            = "visitor.zip"
  s3_key_slack_notification_script = "slack_notification.zip"

  lambda_visitor_name            = "cloud_resume_visitor"
  lambda_slack_notification_name = "cloud_resume_slack_notification"


  apigateway_name       = "cloud_resume_api"
  apigateway_stage_name = "cloud_resume_stage"
  apigateway_route_key  = "PUT /countVisitor"

  sns_topic_name = "cloud_resume"

  dynamodb_visitor_table_name = module.management.dynamodb_visitor_table_name
  dynamodb_ip_table_name      = module.management.dynamodb_ip_table_name

}









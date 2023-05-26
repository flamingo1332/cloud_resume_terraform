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
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "dynamodb" {
  source = "./dynamodb"
}
module "iam" {
  source = "./iam"
}
module "lambda" {
  source = "./lambda"
}









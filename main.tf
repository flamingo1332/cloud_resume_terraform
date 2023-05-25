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

  region = "ap-northeast-1"
  # access_key = var.secrets.AWS_ACCESS_KEY
  # secret_key = var.secrets.AWS_SECRET_KEY
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

module "dynamodb" {
  source = "./dynamodb"
}
module "iam" {
  source = "./iam"
}










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
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "use1"
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}


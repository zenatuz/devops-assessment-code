terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

provider "aws" {
  region                   = "us-east-2"
  shared_config_files      = ["/Users/zenatuz/.aws/conf"]
  shared_credentials_files = ["/Users/zenatuz/.aws/credentials"]
  profile                  = "default"
}

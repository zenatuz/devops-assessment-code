terraform {
  required_version = ">=1.5"

  backend "s3" {
    bucket                  = "renato-batista-terraform-state"
    key                     = "devops-assessment-code-state"
    region                  = "us-east-2"
    shared_credentials_file = "/Users/zenatuz/.aws/creds"
  }
}


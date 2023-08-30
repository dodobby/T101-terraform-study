terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

/*
provider "aws" {
  region     = var.region
  access_key = "{$TF_VAR_AWS_ACCESS_KEY_ID}"
  secret_key = "{$TF_VAR_AWS_SECRET_ACCESS_KEY}"
}
*/

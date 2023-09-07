terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
  backend "s3" {
    bucket = "hjdo-s3-bucket"
    key    = "terraform/ch2/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
    dynamodb_table = "hjdo-dynamodb-table" //this backend also supports state locking and consistency checking via Dynamo DB
    // 리소스 삭제시 로그 : Acquiring state lock. This may take a few moments...
  }
}
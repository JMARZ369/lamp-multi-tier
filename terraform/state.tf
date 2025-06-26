terraform {
  backend "s3" {
  bucket = "lamp-aws-rhel-iac-tf-state"
  key = "global/s3/terraform.tfstate"
  region = "us-east-2"
  dynamodb_table = "s3-tf-table"
  }
}
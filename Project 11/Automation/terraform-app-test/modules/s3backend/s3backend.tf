terraform {
  backend "s3" {
    bucket = "potatobucket5"
    key    = "terraform.tfstate"
	dynamodb_table = "PLock"

    region = "us-west-2"
  }
}
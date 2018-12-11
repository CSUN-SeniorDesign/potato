terraform {
  backend "s3" {
    bucket = "potatobuckets3"
    key    = "terraform.tfstate"
	dynamodb_table = "potatolock"

    region = "us-west-2"
  }
}
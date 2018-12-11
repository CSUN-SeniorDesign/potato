resource "aws_s3_bucket" "potatobucket" {
  bucket = "potatobuckets3"

  versioning {
    enabled = true
  }
  lifecycle {
		prevent_destroy = false
	}
  }
  resource "aws_dynamodb_table" "potatolock" {
  name = "potatolock"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
 
  tags {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
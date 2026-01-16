resource "aws_s3_bucket" "this" {
  bucket = "my-tf-test-bucket-tkg"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.this.id

  block_public_acls = false
  block_public_policy = false
}
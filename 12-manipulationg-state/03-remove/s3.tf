# resource "aws_s3_bucket" "example" {
#   bucket = "my-tf-test-bucket-tkg"
# }

removed {
  from = aws_s3_bucket.example

  lifecycle {
    destroy = false
  }
}
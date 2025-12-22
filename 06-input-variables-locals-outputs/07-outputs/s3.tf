resource "aws_s3_bucket" "output_bucket" {
  bucket = "experts247-${local.project}"

  tags=local.common_tags
  
}

resource "aws_s3_bucket" "local_bucket" {
  bucket = "experts247-${local.project}"

  tags=merge(local.common_tags,var.additional_tags)
}
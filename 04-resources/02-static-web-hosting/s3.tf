resource "aws_s3_bucket" "s3_bucket" {
  bucket = "prod-s3-tkg-2025"

  tags = {
    Name        = "Static Web Hosting Bucket"
    Environment = "Production"
  }
}



resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


data "aws_iam_policy_document" "allow_public_read" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket     = aws_s3_bucket.s3_bucket.id
  policy     = data.aws_iam_policy_document.allow_public_read.json
  depends_on = [aws_s3_bucket_public_access_block.public_access]
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


# Upload index.html
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.s3_bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  #   acl    = "public-read"
}

# Upload error.html (optional)
# resource "aws_s3_object" "error_html" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   key    = "error.html"
#   source = "error.html"
#   content_type = "text/html"
#   acl    = "public-read"
# }

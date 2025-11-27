data "aws_iam_policy_document" "s3_read_only" {
  statement {
    sid = "AllowS3ReadOnly"

    principals {
      type="*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::*",
      "arn:aws:s3:::*/*"
    ]

    effect = "Allow"
  }
}

# resource "aws_iam_policy" "example" {
#   name   = "example_policy"
#   path   = "/"
#   policy = data.aws_iam_policy_document.example.json
# }

output "iam_policy" {
  value = data.aws_iam_policy_document.s3_read_only
}
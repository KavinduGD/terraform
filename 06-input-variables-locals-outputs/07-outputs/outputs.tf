output "s3_bucket_name" {
  sensitive = true
  value=aws_s3_bucket.output_bucket.bucket
  description = "The name of the s3 bucket"
}


variable "my_sensitive_tag" {
  type      = string
  sensitive = true
}

output "sensitive_output_tag" {
  sensitive = true   
  value     = var.my_sensitive_tag
}
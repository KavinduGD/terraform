resource "aws_s3_bucket" "my_imported_bucket" {
    tags = {
        Environment = "dev"
    }

 
}


resource "aws_s3_bucket_public_access_block" "my_bucket_pab" {
  bucket = aws_s3_bucket.my_imported_bucket.id
}

import {
  to = aws_s3_bucket_public_access_block.my_bucket_pab
  id = aws_s3_bucket.my_imported_bucket.id
}
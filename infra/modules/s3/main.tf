resource "aws_s3_bucket" "frontend" {
  bucket = var.bucket_name
  acl    = "public-read"
  website {
    index_document = "index.html"
  }
  tags = var.tags
}

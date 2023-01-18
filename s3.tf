resource "aws_s3_bucket" "wiz-test-bucket" {
  bucket = "wiz-cspm-test-bucket-3467098"
  acl    = "public-read"

  versioning {
    enabled = false
  }
}

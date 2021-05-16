resource "aws_s3_bucket" "pipeline-artifacts" {
  bucket = "my-code-pipeline-artifacts-p1"
  acl = "private"
}

resource "aws_s3_bucket" "sample2" {
  bucket = "prins321-p1-est2"
  acl = "private"
}

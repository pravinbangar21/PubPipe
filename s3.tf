resource "aws_s3_bucket" "pipeline-artifacts" {
  bucket = "my-code-pipeline-artifacts-p1"
  acl = "private"
}
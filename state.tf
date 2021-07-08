terraform {
  backend "s3" {
    bucket = "code-pipeline-p21"
    encrypt = true
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

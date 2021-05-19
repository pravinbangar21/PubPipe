terraform {
  backend "s3" {
    bucket = "p-pipeline21"
    encrypt = true
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}

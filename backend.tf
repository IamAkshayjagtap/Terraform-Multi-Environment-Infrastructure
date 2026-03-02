terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-akshay"
    key            = "multi-env/${terraform.workspace}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
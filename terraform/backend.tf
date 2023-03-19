terraform {
  backend "s3" {
    bucket = "exam-eks-buck"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

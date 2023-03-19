locals {
  default_tags = {
    Terraform = "true"
    Env       = "dev"
  }

  name = "Altschool_exam_staging"

  vpc_cidr = "10.0.0.0/16"
  region   = "us-east-1"

  create_workloads = true

}
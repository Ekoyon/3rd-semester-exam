locals {
  cluster_name = var.cluster_name
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "exam_kub_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  public_subnets  = ["10.0.60.0/24", "10.0.80.0/24", "10.0.100.0/24"]

  map_public_ip_on_launch = false
  enable_dns_hostnames    = true
  enable_nat_gateway = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
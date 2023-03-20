module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = "exam_eks_cluster"
  cluster_version                = "1.25"
  cluster_endpoint_public_access = true
  # EKS Cluster Addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  # VPC

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  # Node Group(s)

  # Using EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.medium", "t3.medium"]
    disk_size      = 50
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 4
      desired_size = 2

      instance_types = ["t2.medium", "t3.medium", "t2.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }


  # aws-auth configmap
  # manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/eks_user"
      username = "eks_user"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::66666666666:user/eks_user1"
      username = "eks_user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/eks_user2"
      username = "eks_user2"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_accounts = [
    "777777777777",
    "888888888888",
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }


}

 

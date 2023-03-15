module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"

    cluster_name = "exam_kub_cluster"
    cluster_version = "1.24"

    cluster_endpoint_public_access = true

    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.private_subnets

    enable_irsa = true

    eks_managed_node_group_defaults = {
    disk_size = 50
    }

    eks_managed_node_groups = {
    general = {
        desired_size = 1
        min_size = 1
        max_size = 10

        labels = {
            role = "gen"
        }
        instance_types = ["t3.small"]
        capacity_type = "ON_MAND"
    } 
    }

    tags = {
        Environment = "dev"
    }
}

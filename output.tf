output "cluster_security_group_id" {
  description = "sg ids attached to cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_endpoint" {
  description = "EKS control plane Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "k8 cluster name"
  value       = module.eks.cluster_name
}

output "cluster_id" {
  description = "k8 cluster id"
  value       = module.eks.cluster_id
}

output "region" {
  description = "AWS region"
  value       = "us-east-1"
}

output "cluster_certificate_authority_data" {
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}


output "aws_auth_configmap_yaml" {
  value = module.eks.aws_auth_configmap_yaml
}
variable "cluster_name" {
  description = "eks cluster Name"
  type        = string
  default     = "exam_eks_cluster"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(any)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Defining associations variable
variable "associations" {
  type = map(object({
    action = string
  }))

  default = {
    "alb-listener" = {
      action = "ALLOW"
    }
  }
}

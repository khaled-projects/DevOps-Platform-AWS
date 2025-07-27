variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix for naming"
  type        = string
  default     = "devops"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "devops-cluster"
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.24"
}

variable "node_group" {
  description = "Node group config"
  type = object({
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
    instance_types   = list(string)
  })
  default = {
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1
    instance_types   = ["t3.medium"]
  }
}

variable "iam_roles" {
  description = "Map of IAM roles"
  type = map(object({
    principal_type = string
    identifiers    = list(string)
    policy_arn     = string
  }))
  default = {}
}

variable "frontend_bucket" {
  description = "S3 bucket name"
  type        = string
  default     = "frontend-spa-bucket"
}

#variable "domain_name" {
# description = "Route53 zone domain"
#  type        = string
#}

#variable "record_name" {
#  description = "DNS record"
#  type        = string
#  default     = "app"
#}

#variable "tags" {
#  description = "Common tags"

 # type        = map(string)
 # default     = { Owner = "devops" }
#}

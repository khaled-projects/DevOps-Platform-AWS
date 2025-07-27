variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "account_id" {
  description = "AWS Account ID"
  type        = string
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


variable "iam_roles" {
  description = "Map of IAM roles"
  type = map(object({
    principal_type = string
    identifiers    = list(string)
    policy_arns    = list(string)   # <- FIX: ici on accepte une liste
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

variable "tags" {
  description = "Common tags"

  type        = map(string)
  default     = { Owner = "devops" }
}

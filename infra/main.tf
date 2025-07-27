provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source         = "./modules/vpc"
  name_prefix    = var.name_prefix
  vpc_cidr       = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  enable_irsa = true

  eks_managed_node_groups = {} # No EC2 nodes

  fargate_profiles = {
    default = {
      selectors = [
        {
          namespace = "default"
        },
        {
          namespace = "kube-system"
        }
      ]
    }
  }

  tags = {
    Environment = "dev"
    Project     = "devops-platform"
  }
}

# Récupération dynamique des infos du cluster
data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_iam_openid_connect_provider" "oidc" {
  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
  depends_on = [data.aws_eks_cluster.this]
}

locals {
  account_id         = data.aws_caller_identity.current.account_id
  region             = var.aws_region
  github_oidc_arn    = "arn:aws:iam::${local.account_id}:oidc-provider/token.actions.githubusercontent.com"
  eks_oidc_arn       = data.aws_iam_openid_connect_provider.oidc.arn

  iam_roles_resolved = {
    for name, role in var.iam_roles : name => {
      principal_type = role.principal_type
      identifiers = [
        for id in role.identifiers :
        replace(replace(id, "GITHUB_OIDC", local.github_oidc_arn), "EKS_OIDC", local.eks_oidc_arn)
      ]
      policy_arns = role.policy_arns
    }
  }
}



module "iam" {
  source = "./modules/iam"
  roles  = local.iam_roles_resolved
}


module "s3" {
  source      = "./modules/s3"
  bucket_name = var.frontend_bucket
  tags        = var.tags
}

#module "route53" {
 # source       = "./modules/route53"
 # domain_name  = var.domain_name
 # record_name  = var.record_name
 # alias_target = module.s3.frontend.website_endpoint
#}

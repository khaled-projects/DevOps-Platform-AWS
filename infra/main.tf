provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source         = "./modules/vpc"
  name_prefix    = var.name_prefix
  cidr_block     = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets
  node_group       = var.node_group
  tags             = var.tags
}

module "iam" {
  source = "./modules/iam"
  roles  = var.iam_roles
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.frontend_bucket
  tags        = var.tags
}

module "route53" {
  source       = "./modules/route53"
  domain_name  = var.domain_name
  record_name  = var.record_name
  alias_target = module.s3.frontend.website_endpoint
}

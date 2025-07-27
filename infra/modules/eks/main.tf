
module "eks_cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.subnet_ids
  vpc_id          = var.vpc_id

  node_groups = {
    default = {
      desired_capacity = var.node_group.desired_capacity
      max_capacity     = var.node_group.max_capacity
      min_capacity     = var.node_group.min_capacity
      instance_types   = var.node_group.instance_types
    }
  }

  tags = var.tags
}

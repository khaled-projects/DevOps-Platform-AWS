module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"       # ou la dernière 18.x compatible avec TF 1.5.0

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # <-- ici on corrige le nom de l’argument
  vpc_id      = var.vpc_id
  subnet_ids  = var.subnet_ids
  tags = var.tags
}


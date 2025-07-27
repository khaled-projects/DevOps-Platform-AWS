iam_roles = {
  # Rôle GitHub Actions pour déployer sur EKS
  github_actions = {
    principal_type = "Federated"
    identifiers    = ["arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"]
    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]
  }

  # Rôle Lambda de backup S3
  lambda_backup = {
    principal_type = "Service"
    identifiers    = ["lambda.amazonaws.com"]
    policy_arns    = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
  }

  # Rôle pour gérer Route53 (par exemple via Terraform)
  route53_manager = {
    principal_type = "Federated"
    identifiers    = ["arn:aws:iam::123456789012:oidc-provider/terraform.example.com"]
    policy_arns    = ["arn:aws:iam::aws:policy/AmazonRoute53FullAccess"]
  }
}


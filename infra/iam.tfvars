# iam.tfvars (corrigé et nettoyé)

roles = {
  github-deploy-role = {
    principal_type = "Federated"
    identifiers    = ["GITHUB_OIDC"] # sera remplacé dynamiquement dans main.tf
    policy_arns    = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  }

  eks-cluster-role = {
    principal_type = "Service"
    identifiers    = ["eks.amazonaws.com"]
    policy_arns    = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
  }

  eks-node-role = {
    principal_type = "Service"
    identifiers    = ["ec2.amazonaws.com"]
    policy_arns    = [
      "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
      "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]
  }

  lambda-backup-role = {
    principal_type = "Service"
    identifiers    = ["lambda.amazonaws.com"]
    policy_arns    = [
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
      "arn:aws:iam::aws:policy/AmazonS3FullAccess",
      "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
    ]
  }

  monitoring-role = {
    principal_type = "Federated"
    identifiers    = ["EKS_OIDC"] # sera remplacé dynamiquement aussi
    policy_arns    = [
      "arn:aws:iam::aws:policy/CloudWatchFullAccess"
    ]
  }

  secrets-access-role = {
    principal_type = "Service"
    identifiers    = ["lambda.amazonaws.com", "ec2.amazonaws.com"]
    policy_arns    = ["arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
  }
}


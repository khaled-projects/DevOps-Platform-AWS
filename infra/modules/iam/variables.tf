variable "roles" {
  description = "Map of IAM roles to create"
  type = map(object({
    principal_type = string       # e.g. "Federated" ou "Service"
    identifiers    = list(string) # liste d'identifiants (ARN OIDC, service principal…)
    policy_arns    = list(string) # liste de ARNs de policies à attacher
  }))
}


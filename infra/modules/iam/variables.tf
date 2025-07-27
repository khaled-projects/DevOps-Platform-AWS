variable "roles" {
  description = "Map of IAM roles to create"
  type = map(object({
    principal_type = string
    identifiers    = list(string)
    policy_arn     = string
  }))
}

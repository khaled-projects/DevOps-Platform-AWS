variable "roles" {
  description = "IAM roles with trust and policies"
  type = map(object({
    principal_type = string       # e.g. "Federated", "Service"
    identifiers    = list(string) # e.g. ["lambda.amazonaws.com"]
    policy_arns    = list(string) # e.g. ["arn:aws:iam::aws:policy/AWSLambdaBasicExecutionRole"]
  }))
}


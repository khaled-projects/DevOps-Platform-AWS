output "role_names" {
  value = [for r in aws_iam_role.this : r.name]
}

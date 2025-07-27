resource "aws_iam_role" "this" {
  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.trust[each.key].json
}

data "aws_iam_policy_document" "trust" {
  for_each = var.roles
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = each.value.principal_type
      identifiers = each.value.identifiers
    }
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each  = var.roles
  role      = aws_iam_role.this[each.key].name
  policy_arn = each.value.policy_arn
}

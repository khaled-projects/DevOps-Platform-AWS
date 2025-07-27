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

resource "aws_iam_role" "this" {
  for_each            = var.roles
  name                = each.key
  assume_role_policy  = data.aws_iam_policy_document.trust[each.key].json
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each   = {
    for role_key, role_conf in var.roles :
    "${role_key}-${basename(role_conf.policy_arns[*])}" => {
      role_key   = role_key
      policy_arn = role_conf.policy_arns
    }
  }
  role       = aws_iam_role.this[each.value.role_key].name
  policy_arn = each.value.policy_arn[0]  # cf. boucle ci‑dessus, tu peux aussi itérer policy_arns[*]
}


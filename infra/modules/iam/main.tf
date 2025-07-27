data "aws_iam_policy_document" "assume_role" {
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
  for_each           = var.roles
  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role[each.key].json

  tags = {
    Name = each.key
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  for_each = {
    for pair in flatten([
      for role_key, role_def in var.roles : [
        for policy_arn in role_def.policy_arns : {
          key        = "${role_key}-${replace(policy_arn, ":", "_")}"
          role       = role_key
          policy_arn = policy_arn
        }
      ]
    ]) : pair.key => {
      role       = pair.role
      policy_arn = pair.policy_arn
    }
  }

  role       = each.value.role
  policy_arn = each.value.policy_arn
}



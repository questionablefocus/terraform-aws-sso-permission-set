resource "aws_ssoadmin_permission_set" "main" {
  instance_arn     = var.instance_arn
  name             = var.name
  session_duration = var.session_duration
}

resource "aws_ssoadmin_managed_policy_attachment" "main" {
  for_each           = toset(var.managed_policy_arns)
  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.main.arn
  managed_policy_arn = each.value
}

resource "aws_ssoadmin_permission_set_inline_policy" "main" {
  count              = var.inline_policy != null ? 1 : 0
  instance_arn       = var.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.main.arn
  inline_policy      = var.inline_policy
}

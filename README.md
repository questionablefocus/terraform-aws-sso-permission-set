# terraform-aws-sso-permission-set

A basic cosmetic wrapper around the `aws_sso_permission_set` and related Terraform resources.

## Features

- Attach managed AWS policies
- Provide a policy document for further customisations

## Examples

### Basic configuration

```hcl
locals {
  sso_instance_arn  = tolist(data.aws_ssoadmin_instances.all.arns)[0]
}

module "read_only_permission_set" {
  source  = "./modules/sso_permission_set"
  version = "1.0.0"

  name         = "ReadOnlyAccess"
  instance_arn = local.sso_instance_arn

  managed_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}
```

### Allow read-only billing access

Define an `aws_iam_policy_document` to reference it in the module.

```hcl
locals {
  sso_instance_arn  = tolist(data.aws_ssoadmin_instances.all.arns)[0]
}

module "read_only_permission_set" {
  source  = "./modules/sso_permission_set"
  version = "1.0.0"

  name         = "ReadOnlyAccess"
  instance_arn = local.sso_instance_arn

  managed_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
  inline_policy       = data.aws_iam_policy_document.read_only.json
}

data "aws_iam_policy_document" "read_only" {
  statement {
    sid    = "Billing"
    effect = "Allow"
    actions = [
      "ce:Get*",
      "ce:Describe*",
      "cur:DescribeReportDefinitions",
      "budgets:ViewBudget",
      "budgets:Describe*",
      "aws-portal:ViewBilling",
      "aws-portal:ViewAccount",
      "aws-portal:ViewUsage",
      "aws-portal:ViewPaymentMethods",
      "aws-portal:ViewBudget",
      "pricing:GetProducts",
      "purchase-orders:ViewPurchaseOrders"
    ]
    resources = ["*"]
  }
}
```

locals {
  policies = [
    "${data.aws_iam_policy_document.s3_readonly.*.json}",
    "${data.aws_iam_policy_document.s3_write.*.json}",
  ]
}

module "policy_condenser" {
  source = "../tf-aws-iam-policy-condenser"

  policy_type = "user"

  input_policies = [
    "${local.policies}",
  ]
}

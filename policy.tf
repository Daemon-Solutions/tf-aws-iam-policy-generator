locals {
  policies = [
    "${data.aws_iam_policy_document.s3_readonly.*.json}",
    "${data.aws_iam_policy_document.s3_write.*.json}",
  ]
}

module "policy_condenser" {
  source = "git::ssh://git@gitlab.com/claranet-pcp/terraform/aws/tf-aws-iam-policy-condenser.git"

  policy_type = "${var.policy_type}"

  input_policies = [
    "${local.policies}",
  ]
}

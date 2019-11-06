module "policy_condenser" {
  source = "git::ssh://git@gitlab.com/claranet-pcp/terraform/aws/tf-aws-iam-policy-condenser.git?ref=v1.0.0"

  policy_type = "${var.policy_type}"

  input_policies = [
    "${data.aws_iam_policy_document.apigateway_full_access.*.json}",
    "${data.aws_iam_policy_document.apigateway_read.*.json}",
    "${data.aws_iam_policy_document.apigateway_write.*.json}",
    "${data.aws_iam_policy_document.cloudcraft_access.*.json}",
    "${data.aws_iam_policy_document.dynamodb_full_access.*.json}",
    "${data.aws_iam_policy_document.dynamodb_list.*.json}",
    "${data.aws_iam_policy_document.dynamodb_read.*.json}",
    "${data.aws_iam_policy_document.dynamodb_write.*.json}",
    "${data.aws_iam_policy_document.iam_change_password.*.json}",
    "${data.aws_iam_policy_document.lambda_full_access.*.json}",
    "${data.aws_iam_policy_document.lambda_invoke.*.json}",
    "${data.aws_iam_policy_document.lambda_list.*.json}",
    "${data.aws_iam_policy_document.lambda_read.*.json}",
    "${data.aws_iam_policy_document.lambda_write.*.json}",
    "${data.aws_iam_policy_document.s3_full_access.*.json}",
    "${data.aws_iam_policy_document.s3_list.*.json}",
    "${data.aws_iam_policy_document.s3_read.*.json}",
    "${data.aws_iam_policy_document.s3_write.*.json}",
    "${data.aws_iam_policy_document.sqs_full_access.*.json}",
    "${data.aws_iam_policy_document.sqs_list_queues.*.json}",
    "${data.aws_iam_policy_document.sqs_read.*.json}",
    "${data.aws_iam_policy_document.sqs_write.*.json}",
  ]
}

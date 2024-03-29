locals {
  generated_policies = [
    data.aws_iam_policy_document.apigateway_full_access.*.json,
    data.aws_iam_policy_document.apigateway_invoke.*.json,
    data.aws_iam_policy_document.apigateway_read.*.json,
    data.aws_iam_policy_document.apigateway_post.*.json,
    data.aws_iam_policy_document.apigateway_write.*.json,
    data.aws_iam_policy_document.cloudcraft_access.*.json,
    data.aws_iam_policy_document.cloudwatch_full_access.*.json,
    data.aws_iam_policy_document.cloudwatch_full_access_dashboard.*.json,
    data.aws_iam_policy_document.cloudwatch_full_alarm_access.*.json,
    data.aws_iam_policy_document.cloudwatch_event_full_access_resources.*.json,
    data.aws_iam_policy_document.cloudwatch_read_only.*.json,
    data.aws_iam_policy_document.dynamodb_full_access.*.json,
    data.aws_iam_policy_document.dynamodb_list.*.json,
    data.aws_iam_policy_document.dynamodb_read.*.json,
    data.aws_iam_policy_document.dynamodb_write.*.json,
    data.aws_iam_policy_document.ec2_full_access.*.json,
    data.aws_iam_policy_document.ec2_read.*.json,
    data.aws_iam_policy_document.iam_change_password.*.json,
    data.aws_iam_policy_document.iam_get_account_password_policy.*.json,
    data.aws_iam_policy_document.iam_manage_access_key.*.json,
    data.aws_iam_policy_document.ecs_list.*.json,
    data.aws_iam_policy_document.ecs_read.*.json,
    data.aws_iam_policy_document.ecs_write.*.json,
    data.aws_iam_policy_document.lambda_full_access.*.json,
    data.aws_iam_policy_document.lambda_invoke.*.json,
    data.aws_iam_policy_document.lambda_list.*.json,
    data.aws_iam_policy_document.lambda_read.*.json,
    data.aws_iam_policy_document.lambda_write.*.json,
    data.aws_iam_policy_document.redshift_full_access.*.json,
    data.aws_iam_policy_document.redshift_read_only.*.json,
    data.aws_iam_policy_document.s3_full_access.*.json,
    data.aws_iam_policy_document.s3_list.*.json,
    data.aws_iam_policy_document.s3_read.*.json,
    data.aws_iam_policy_document.s3_write.*.json,
    data.aws_iam_policy_document.sns_full_access.*.json,
    data.aws_iam_policy_document.sns_list.*.json,
    data.aws_iam_policy_document.sns_read.*.json,
    data.aws_iam_policy_document.sns_write.*.json,
    data.aws_iam_policy_document.pi_full_access.*.json,
    data.aws_iam_policy_document.sqs_full_access.*.json,
    data.aws_iam_policy_document.sqs_list_queues.*.json,
    data.aws_iam_policy_document.sqs_read.*.json,
    data.aws_iam_policy_document.sqs_write.*.json,
    data.aws_iam_policy_document.ssm_parameters_full_access.*.json,
    data.aws_iam_policy_document.ssm_parameters_list.*.json,
    data.aws_iam_policy_document.ssm_parameters_read.*.json,
    data.aws_iam_policy_document.ssm_parameters_write.*.json,
  ]
}

module "policy_condenser" {
  source = "git@github.com:Daemon-Solutions/tf-aws-iam-policy-condenser.git?ref=v2.0.0"

  policy_type = var.policy_type

  input_policies = concat(
    flatten(local.generated_policies),
    data.template_file.managed_policies.*.rendered
  )
}

output "managed_policies" {
  value = jsonencode(data.template_file.managed_policies.*.rendered)
}

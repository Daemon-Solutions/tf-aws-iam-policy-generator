module "test_user_iam_policy" {
  source = "../../"

  policy_type = "group"

  apigateway_read      = true
  apigateway_read_apis = ["arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:abcdefg/*"]

  apigateway_write      = true
  apigateway_write_apis = ["arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:abcdefg/*"]

  apigateway_full_access      = true
  apigateway_full_access_apis = ["arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:abcdefg/*"]

  cloudcraft_access = true

  dynamodb_read        = true
  dynamodb_read_tables = ["arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/mytable"]

  dynamodb_write        = true
  dynamodb_write_tables = ["arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/mytable"]

  dynamodb_full_access        = true
  dynamodb_full_access_tables = ["arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/mytable"]

  lambda_read           = true
  lambda_read_functions = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:test"]

  lambda_invoke           = true
  lambda_invoke_functions = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:test"]

  lambda_write           = true
  lambda_write_functions = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:test"]

  lambda_full_access           = true
  lambda_full_access_functions = ["arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:test"]

  s3_read = true

  s3_read_buckets = [
    "arn:aws:s3:::test-bucket1",
    "arn:aws:s3:::test-bucket2",
    "arn:aws:s3:::test-bucket3",
    "arn:aws:s3:::test-bucket4",
    "arn:aws:s3:::test-bucket5",
    "arn:aws:s3:::test-bucket6",
    "arn:aws:s3:::test-bucket7",
    "arn:aws:s3:::test-bucket8",
    "arn:aws:s3:::test-bucket9",
    "arn:aws:s3:::test-bucket10",
    "arn:aws:s3:::test-bucket11",
    "arn:aws:s3:::test-bucket12",
    "arn:aws:s3:::test-bucket13",
    "arn:aws:s3:::test-bucket14",
    "arn:aws:s3:::test-bucket15",
    "arn:aws:s3:::test-bucket16",
    "arn:aws:s3:::test-bucket17",
    "arn:aws:s3:::test-bucket18",
    "arn:aws:s3:::test-bucket19",
    "arn:aws:s3:::test-bucket20",
  ]

  s3_write = true

  s3_write_buckets = [
    "arn:aws:s3:::test-bucket1",
    "arn:aws:s3:::test-bucket2",
    "arn:aws:s3:::test-bucket3",
    "arn:aws:s3:::test-bucket4",
    "arn:aws:s3:::test-bucket5",
    "arn:aws:s3:::test-bucket6",
    "arn:aws:s3:::test-bucket7",
    "arn:aws:s3:::test-bucket8",
    "arn:aws:s3:::test-bucket9",
    "arn:aws:s3:::test-bucket10",
    "arn:aws:s3:::test-bucket11",
    "arn:aws:s3:::test-bucket12",
    "arn:aws:s3:::test-bucket13",
    "arn:aws:s3:::test-bucket14",
    "arn:aws:s3:::test-bucket15",
    "arn:aws:s3:::test-bucket16",
    "arn:aws:s3:::test-bucket17",
    "arn:aws:s3:::test-bucket18",
    "arn:aws:s3:::test-bucket19",
    "arn:aws:s3:::test-bucket20",
  ]

  s3_full_access         = "1"
  s3_full_access_buckets = ["arn:aws:s3:::test-bucket1"]

  sqs_list        = true
  sqs_read        = true
  sqs_read_queues = ["arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:myqueue"]

  sqs_write        = true
  sqs_write_queues = ["arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:myqueue"]

  sqs_full_access        = true
  sqs_full_access_queues = ["arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:myqueue"]

  iam_change_password = true
}

resource "aws_iam_policy" "user_policies" {
  count  = "${length(module.test_user_iam_policy.policies)}"
  policy = "${lookup(module.test_user_iam_policy.policies[count.index], "policies")}"
}

output "policies" {
  value = "${module.test_user_iam_policy.policies}"
}
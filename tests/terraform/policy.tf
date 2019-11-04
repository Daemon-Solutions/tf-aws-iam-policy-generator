module "test_user_iam_policy" {
  source = "../../"

  policy_type = "group"

  apigateway_read = true

  apigateway_read_apis = [
    "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:abcdefg/*",
  ]

  dynamodb_read = true

  dynamodb_read_tables = [
    "arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/mytable",
  ]

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

  s3_full_access = "1"

  s3_full_access_buckets = [
    "arn:aws:s3:::test-bucket1",
  ]
}

resource "aws_iam_policy" "user_policies" {
  count  = "${length(module.test_user_iam_policy.policies)}"
  policy = "${lookup(module.test_user_iam_policy.policies[count.index], "policies")}"
}

output "policies" {
  value = "${module.test_user_iam_policy.policies}"
}
data "aws_iam_policy_document" "dynamodb_list" {
  count = "${var.dynamodb_read == "1" || var.dynamodb_write == "1" || var.dynamodb_full_access == "1" || var.dynamodb_list == "1" ? "1" : "0"}"

  statement {
    sid    = "DynamoDBListAndDescribeTables"
    effect = "Allow"

    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "dynamodb_read" {
  count = "${var.dynamodb_read}"

  statement {
    sid = "DynamoDBReadOnlyTableAccess"

    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:Get*",
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = ["${var.dynamodb_read_tables}"]
  }
}

data "aws_iam_policy_document" "dynamodb_write" {
  count = "${var.dynamodb_write}"

  statement {
    sid = "DynamoDBWriteTableAccess"

    actions = [
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
      "dynamodb:PutItem",
    ]

    effect = "Allow"

    resources = [
      "${var.dynamodb_write_tables}",
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_full_access" {
  count = "${var.dynamodb_full_access}"

  statement {
    sid = "DynamoDBFullAccessTables"

    actions = [
      "s3:*)",
    ]

    effect = "Allow"

    resources = [
      "${var.dynamodb_full_access_tables}",
    ]
  }
}

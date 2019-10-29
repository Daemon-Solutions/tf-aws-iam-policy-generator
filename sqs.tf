data "aws_iam_policy_document" "sqs_list_queues" {
  count = "${var.sqs_readonly == "1" || var.sqs_write == "1" || var.sqs_full_access == "1" || var.sqs_list == "1" ? "1" : "0"}"

  statement {
    sid = "SQSListQueues"

    actions = [
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListQueueTags",
      "sqs:ListQueues",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sqs_readonly" {
  count = "${var.sqs_readonly}"

  statement {
    sid = "SQSReadAccessQueues"

    actions = [
      "sqs:ReceiveMessage",
    ]

    resources = "${var.sqs_read_queues}"
  }
}

data "aws_iam_policy_document" "sqs_write" {
  count = "${var.sqs_write}"

  statement {
    sid = "SQSWriteAccessQueues"

    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
    ]

    resources = "${var.sqs_write_queues}"
  }
}

data "aws_iam_policy_document" "sqs_full_access" {
  count = "${var.sqs_full_access}"

  statement {
    sid       = "SQSFullAccessQueues"
    actions   = ["sqs:*"]
    resources = "${var.sqs_full_access_queues}"
  }
}
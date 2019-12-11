variable "sns_list" {
  description = "Boolean indicating whether to create a policy to allow listing SNS topics (this is automatically added if any other access to buckets is granted)"
  default     = false
}

variable "sns_read" {
  description = "Boolean indicating whether to give Read Only access to SNS Topics."
  default     = false
}

variable "sns_read_topics" {
  description = "A list of SNS Topics which the user has Read Only access too."
  type        = "list"
  default     = []
}

variable "sns_write" {
  description = "Boolean indicating whether to create a policy to allow write access to a SNS topics."
  default     = false
}

variable "sns_write_topics" {
  description = "A list of SNS topics to create policies to allow writing to."
  type        = "list"
  default     = []
}

variable "sns_full_access" {
  description = "Boolean indicating whether to give Full Access to the SNS Topics."
  default     = false
}

variable "sns_full_access_topics" {
  description = "A list of SNS Topics which the user has Full Access too."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "sns_list" {
  count = "${var.sns_list || var.sns_read || var.sns_write || var.sns_full_access ? "1" : "0"}"

  statement {
    sid = "SNSListAndGetTopics"

    actions = [
      "sns:Get*",
      "sns:List*",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "sns_read" {
  count = "${var.sns_read}"

  statement {
    sid = "SNSReadTopics"

    actions = [
      "sns:Subscribe",
      "sns:Unsubscribe",
    ]

    resources = ["${var.sns_read_topics}"]
  }
}

data "aws_iam_policy_document" "sns_write" {
  count = "${var.sns_write}"

  statement {
    sid = "SNSWriteTopics"

    actions = [
      "sns:Publish",
    ]

    resources = ["${var.sns_write_topics}"]
  }
}

data "aws_iam_policy_document" "sns_full_access" {
  count = "${var.sns_full_access}"

  statement {
    sid = "SNSFullAccess"

    actions = [
      "sns:*",
    ]

    resources = ["${var.sns_full_access_topics}"]
  }
}

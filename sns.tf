variable "sns_read" {
  description = "Boolean indicating whether to give Read Only access to SNS Topics."
  default     = false
}

variable "sns_read_topics" {
  description = "A list of SNS Topics which the user has Read Only access too."
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

data "aws_iam_policy_document" "sns_read_only" {
  count = "${var.sns_read}"

  statement {
    sid = "SNSListAndGet"

    actions = [
      "sns:GetTopicAttributes",
      "sns:List*",
    ]

    resources = ["${var.sns_read_topics}"]
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

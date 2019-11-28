variable "kinesis_read" {
  description = "Boolean indicating whether to give Read Only access to Kinesis."
  default     = false
}

variable "kinesis_read_only_resources" {
  description = "A list of Kinesis resources which the user has Read Only access too."
  type        = "list"
  default     = []
}

variable "kinesis_full_access" {
  description = "Boolean indicating whether to give Full Access to the Kinesis Resources."
  default     = false
}

variable "kinesis_full_access_resources" {
  description = "A list of Kinesis resources which the user has Full Access too."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "kinesis_read_only" {
  count = "${var.kinesis_read}"

  statement {
    sid = "KinesisReadOnlyGetListDescribe"

    actions = [
      "kinesis:Describe*",
      "kinesis:List*",
      "kinesis:Get*"
    ]

    resources = ["${var.kinesis_read_only_resources}"]
  }
}

data "aws_iam_policy_document" "kinesis_full_access" {
  count = "${var.kinesis_full_access}"

  statement {
    sid = "KinesisFullAccess"

    actions = [
      "kinesis:*",
    ]

    resources = ["${var.kinesis_full_access_resources}"]
  }
}

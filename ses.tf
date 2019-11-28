variable "ses_read" {
  description = "Boolean indicating whether to give Read Only access to SES."
  default     = false
}

variable "ses_read_only_resources" {
  description = "A list of SES resources which the user has Read Only access too."
  type        = "list"
  default     = []
}

variable "ses_full_access" {
  description = "Boolean indicating whether to give Full Access to the SES Resources."
  default     = false
}

variable "ses_full_access_resources" {
  description = "A list of SES resources which the user has Full Access too."
  type        = "list"
  default     = []
}

variable "ses_send_raw_email" {
  description = "Boolean indicating whether to the sending of raw emails through SES."
  default     = false
}

variable "ses_send_raw_email_resources" {
  description = "A list of SES resources through which raw emails will be sent."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "ses_send_raw_email" {
  count = "${var.ses_send_raw_email}"

  statement {
    sid = "SESSendRawEmail"

    actions = [
      "ses:SendRawEmail",
    ]

    resources = ["${var.ses_send_raw_email_resources}"]
  }
}

data "aws_iam_policy_document" "ses_read_only" {
  count = "${var.ses_read}"

  statement {
    sid = "SESReadOnlyGetList"

    actions = [
      "ses:Get*",
      "ses:List*",
    ]

    resources = ["${var.ses_read_only_resources}"]
  }
}

data "aws_iam_policy_document" "ses_full_access" {
  count = "${var.ses_full_access}"

  statement {
    sid = "SESFullAccess"

    actions = [
      "ses:*",
    ]

    resources = ["${var.ses_full_access_resources}"]
  }
}

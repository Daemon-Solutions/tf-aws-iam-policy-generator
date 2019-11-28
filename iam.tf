variable "iam_change_password" {
  description = "Boolean indicating whether to give the policy the IAM:ChangePassword permission"
  default     = false
}

variable "iam_get_account_password_policy" {
  description = "Boolean indicating whether to give the policy the IAM:GetAccountPasswordPolicy permission"
  default     = false
}

variable "iam_manage_access_key" {
  description = "Boolean indicating whether to give the policy the IAM:*AccessKey* permission"
  default     = false
}

data "aws_iam_policy_document" "iam_change_password" {
  count = "${var.iam_change_password}"

  statement {
    sid = "IAMChangePassword"

    actions = [
      "iam:ChangePassword",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_get_account_password_policy" {
  count = "${var.iam_get_account_password_policy}"

  statement {
    sid = "IAMGetAccountPasswordPolicy"

    actions = [
      "iam:GetAccountPasswordPolicy",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_manage_access_key" {
  count = "${var.iam_manage_access_key}"

  statement {
    sid = "IAMManageAccessKey"

    actions = [
      "iam:*AccessKey*",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

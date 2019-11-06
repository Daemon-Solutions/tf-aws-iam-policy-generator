variable "iam_change_password" {
  description = "Boolean indicating whether to give the policy the IAM:ChangePassword permission"
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
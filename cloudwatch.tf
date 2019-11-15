variable "cloudwatch_read" {
  description = "Boolean indicating whether to give the policy the CloudWatchReadOnlyAccess permission"
  default     = false
}

variable "cloudwatch_full_access" {
  description = "Boolean indicating whether to give the policy the CloudWatchFullAccess permission"
  default     = false
}

data "aws_iam_policy_document" "cloudwatch_readonly_access" {
  count = "${var.cloudwatch_read}"

  statement {
    sid = "cloudwatchreadonly"

    actions = [
      "autoscaling:Describe*",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "logs:Get*",
      "logs:List*",
      "logs:Describe*",
      "logs:TestMetricFilter",
      "logs:FilterLogEvents",
      "sns:Get*",
      "sns:List*",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  count = "${var.cloudwatch_full_access}"

  statement {
    sid = "cloudwatchfullaccess1"

    actions = [
      "autoscaling:Describe*",
      "cloudwatch:*",
      "logs:*",
      "sns:*",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }

  statement {
    sid = "cloudwatchfullaccess2"

    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
      "arn:aws:iam::*:user/$${aws:username}",
    ]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"
      values   = [
        "events.amazonaws.com",
      ]
    }
  }
}

variable "cloudwatch_read" {
  description = "Boolean indicating whether to give the policy the CloudWatchReadOnlyAccess permission"
  default     = false
}

variable "cloudwatch_read_list" {
  description = "A list of CloudWatch resources the user is allowed read only access too"
  type        = "list"
  default     = []
}

variable "cloudwatch_full_access" {
  description = "Boolean indicating whether to give the policy the CloudWatchFullAccess permission"
  default     = false
}

variable "cloudwatch_full_access_list" {
  description = "A list of CloudWatch resources the user full access too"
  type        = "list"
  default     = []
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

    resources = ["${var.cloudwatch_read_list}"]
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

    resources = ["${var.cloudwatch_full_access_list}"]
  }

  statement {
    sid = "cloudwatchfullaccess2"

    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
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

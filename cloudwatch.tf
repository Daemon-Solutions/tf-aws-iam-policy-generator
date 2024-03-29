variable "cloudwatch_read" {
  description = "Boolean indicating whether to give Read Only access to CloudWatch."
  default     = false
}

variable "cloudwatch_read_only_resources" {
  description = "A list of Cloudwatch resources to which the user has Read Only access too."
  type        = list(string)
  default     = []
}

variable "cloudwatch_full_access_dashboard" {
  description = "Boolean indicating whether to give Full Dashboard access to CloudWatch."
  type        = string
  default     = false
}

variable "cloudwatch_full_access_dashboard_resources" {
  description = "A list of Cloudwatch resources to which the user has Full Dashboard access."
  type        = list(string)
  default     = []
}

variable "cloudwatch_full_alarm_access" {
  description = "Boolean indicating whether to give Full access to CloudWatch Alarms."
  type        = string
  default     = false
}

variable "cloudwatch_full_alarm_access_resources" {
  description = "A list of Cloudwatch Alarms resources to which the user has Full access."
  type        = list(string)
  default     = []
}

variable "cloudwatch_full_access" {
  description = "Boolean indicating whether to give Full Access to CloudWatch."
  default     = false
}

variable "cloudwatch_full_access_resources" {
  description = "A list of CloudWatch resources to which the user has Full Access too."
  type        = list(string)
  default     = []
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  count = var.cloudwatch_read ? 1 : 0

  statement {
    sid = "CloudWatchROAutoscalingDescribe"

    actions = [
      "autoscaling:Describe*",
    ]

    resources = var.cloudwatch_read_only_resources
  }

  statement {
    sid = "CloudWatchRODescribeGetList"

    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
    ]

    resources = var.cloudwatch_read_only_resources
  }

  statement {
    sid = "CloudWatchROLogsGetListDescribeFilter"

    actions = [
      "logs:Get*",
      "logs:List*",
      "logs:Describe*",
      "logs:TestMetricFilter",
      "logs:FilterLogEvents",
    ]

    resources = var.cloudwatch_read_only_resources
  }

  statement {
    sid = "CloudWatchROSNSListAndGet"

    actions = [
      "sns:Get*",
      "sns:List*",
    ]

    resources = var.cloudwatch_read_only_resources
  }
}

data "aws_iam_policy_document" "cloudwatch_full_access_dashboard" {
  count = var.cloudwatch_full_access_dashboard ? 1 : 0

  statement {
    sid = "CloudWatchFullAccessAutoscalingDescribe"

    actions = [
      "cloudwatch:*Dashboard*",
      "logs:PutMetricFilter",
      "logs:DeleteMetricFilter",
    ]

    resources = var.cloudwatch_full_access_dashboard_resources
  }
}

data "aws_iam_policy_document" "cloudwatch_full_alarm_access" {
  count = var.cloudwatch_full_access_dashboard ? 1 : 0

  statement {
    sid = "CloudWatchFullMetricsAccess"

    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
    ]

    resources = var.cloudwatch_full_alarm_access_resources
  }
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  count = var.cloudwatch_full_access ? 1 : 0

  statement {
    sid = "CloudWatchFullAccessAutoscalingDescribe"

    actions = [
      "autoscaling:Describe*",
    ]

    resources = var.cloudwatch_full_access_resources
  }

  statement {
    sid = "CloudWatchFullAccess"

    actions = [
      "cloudwatch:*",
    ]

    resources = var.cloudwatch_full_access_resources
  }

  statement {
    sid = "CloudWatchFullAccessLogsFullAccess"

    actions = [
      "logs:*",
    ]

    resources = var.cloudwatch_full_access_resources
  }

  statement {
    sid = "CloudWatchFullAccessSNSFullAccess"

    actions = [
      "sns:*",
    ]

    resources = var.cloudwatch_full_access_resources
  }

  statement {
    sid = "CloudWatchFullAccessIAMGetPolicyGetRole"

    actions = [
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
    ]

    resources = var.cloudwatch_full_access_resources
  }

  statement {
    sid = "CloudWatchFullAccessCreateServiceLinkedRole"

    actions = ["iam:CreateServiceLinkedRole"]

    resources = ["arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "events.amazonaws.com",
      ]
    }
  }
}

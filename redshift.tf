variable "redshift_read" {
  description = "Boolean indicating whether to give Read Only access to Redshift."
  default     = false
}

variable "redshift_read_only_instances" {
  description = "A list of Redshift instances which the user has Read Only access too."
  type        = list(string)
  default     = []
}

variable "redshift_full_access" {
  description = "Boolean indicating whether to give Full Access to the Redshift instances."
  default     = false
}

variable "redshift_full_access_instances" {
  description = "A list of Redshift instances which the user has Full Access too."
  type        = list(string)
  default     = []
}

data "aws_iam_policy_document" "redshift_read_only" {
  count = var.redshift_read ? 1 : 0

  statement {
    sid = "RedshiftRODescribeViewQueries"

    actions = [
      "redshift:Describe*",
      "redshift:ViewQueriesInConsole",
    ]

    resources = var.redshift_read_only_instances
  }

  statement {
    sid = "RedshiftROEC2Describe"

    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:DescribeInternetGateways",
    ]

    resources = var.redshift_read_only_instances
  }

  statement {
    sid = "RedshiftROSNSListAndGet"

    actions = [
      "sns:Get*",
      "sns:List*",
    ]

    resources = var.redshift_read_only_instances
  }

  statement {
    sid = "RedshiftROCloudWatchGetListDescribe"

    actions = [
      "sns:Get*",
      "sns:List*",
    ]

    resources = var.redshift_read_only_instances
  }
}

data "aws_iam_policy_document" "redshift_full_access" {
  count = var.redshift_full_access ? 1 : 0

  statement {
    sid = "RedshiftFullAccess"

    actions = [
      "redshift:*",
    ]

    resources = var.redshift_full_access_instances
  }

  statement {
    sid = "RedshiftFullAccessEC2Describe"

    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:DescribeInternetGateways",
    ]

    resources = var.redshift_full_access_instances
  }

  statement {
    sid = "RedshiftFullAccessSNSCreateListGet"

    actions = [
      "sns:CreateTopic",
      "sns:Get*",
      "sns:List*",
    ]

    resources = var.redshift_full_access_instances
  }

  statement {
    sid = "RedshiftFullAccessCloudWatchAccess"

    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:EnableAlarmActions",
      "cloudwatch:DisableAlarmActions",
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricWidgetImage",
      "cloudwatch:GetMetricData",
    ]

    resources = var.redshift_full_access_instances
  }

  statement {
    sid = "RedshiftFullAccessTags"

    actions = [
      "tag:GetResources",
      "tag:UntagResources",
      "tag:GetTagValues",
      "tag:GetTagKeys",
      "tag:TagResources",
    ]

    resources = var.redshift_full_access_instances
  }

  statement {
    sid = "RedshiftFullAccessCreateServiceLinkedRole"

    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = ["arn:aws:iam::*:role/aws-service-role/redshift.amazonaws.com/AWSServiceRoleForRedshift"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "redshift.amazonaws.com",
      ]
    }
  }
}

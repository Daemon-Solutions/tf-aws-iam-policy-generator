variable "ec2_read" {
  description = "Boolean indicating whether to give Read Only access to EC2 instances."
  default     = false
}

variable "ec2_read_instances" {
  description = "A list of EC2 instances which the user has Read Only access too."
  type        = "list"
  default     = []
}

variable "ec2_full_access" {
  description = "Boolean indicating whether to give Full Access to EC2 instances."
  default     = false
}

variable "ec2_full_access_instances" {
  description = "A list of EC2 instances which the user has Full Access too."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "ec2_read" {
  count = "${var.ec2_read}"

  statement {
    sid = "EC2ReadOnlyDescribe"

    actions = [
      "ec2:Describe*",
    ]

    resources = ["${var.ec2_read_instances}"]
  }

  statement {
    sid = "EC2ReadOnlyElasticLoadBalancingDescribe"

    actions = [
      "elasticloadbalancing:Describe*",
    ]

    resources = ["arn:aws:elasticloadbalancing:::*"]
  }

  statement {
    sid = "EC2ReadOnlyCloudWatchGetAndDescribe"

    actions = [
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:Describe*",
    ]

    resources = ["arn:aws:cloudwatch:::*"]
  }

  statement {
    sid = "EC2ReadOnlyAutoscalingDescribe"

    actions = [
      "autoscaling:Describe*",
    ]

    resources = ["arn:aws:autoscaling:::*"]
  }
}

data "aws_iam_policy_document" "ec2_full_access" {
  count = "${var.ec2_full_access}"

  statement {
    sid = "EC2FullAccess"

    actions = [
      "ec2:*",
    ]

    resources = ["${var.ec2_full_access_instances}"]
  }

  statement {
    sid = "EC2FullAccessElasticLoadBalancingFullAccess"

    actions = [
      "elasticloadbalancing:*",
    ]

    resources = ["arn:aws:elasticloadbalancing:::*"]
  }

  statement {
    sid = "EC2FullAccessCloudWatchFullAccess"

    actions = [
      "cloudwatch:*",
    ]

    resources = ["arn:aws:cloudwatch:::*"]
  }

  statement {
    sid = "EC2FullAccessAutoscalingFullAccess"

    actions = [
      "autoscaling:*",
    ]

    resources = ["arn:aws:autoscaling:::*"]
  }

  statement {
    sid = "EC2FullAccessCreateServiceLinkedRole"

    actions = ["iam:CreateServiceLinkedRole"]

    resources = ["arn:aws:iam:::*"]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "autoscaling.amazonaws.com",
        "ec2scheduled.amazonaws.com",
        "elasticloadbalancing.amazonaws.com",
        "spot.amazonaws.com",
        "spotfleet.amazonaws.com",
        "transitgateway.amazonaws.com",
      ]
    }
  }
}

variable "cloudfront_read" {
  description = "Boolean indicating whether to give Read Only access to CloudFront."
  default     = false
}

variable "cloudfront_read_only_resources" {
  description = "A list of CloudFront resources which the user has Read Only access too."
  type        = "list"
  default     = []
}

variable "cloudfront_full_access" {
  description = "Boolean indicating whether to give Full Access to the CloudFront Resources."
  default     = false
}

variable "cloudfront_full_access_resources" {
  description = "A list of CloudFront resources which the user has Full Access too."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "cloudfront_read_only" {
  count = "${var.cloudfront_read}"

  statement {
    sid = "CloudFrontReadOnlyListCertificates"

    actions = [
      "acm:ListCertificates",
    ]

    resources = ["arn:aws:acm:::*"]
  }

  statement {
    sid = "CloudFrontReadOnlyListServerCertificates"

    actions = [
      "iam:ListServerCertificates",
    ]

    resources = ["arn:aws:iam:::*"]
  }

  statement {
    sid = "CloudFrontReadOnlyWAFListGetWebACL"

    actions = [
      "waf:ListWebACLs",
      "waf:GetWebACL",
    ]

    resources = ["arn:aws:waf:::*"]
  }

  statement {
    sid = "CloudFrontReadOnlyRoute53List"

    actions = [
      "route53:List*",
    ]

    resources = ["arn:aws:route53:::*"]
  }

  statement {
    sid = "CloudFrontReadOnlyAccess"

    actions = [
      "cloudfront:Get*",
      "cloudfront:List*",
    ]

    resources = ["${var.cloudfront_read_only_resources}"]
  }
}

data "aws_iam_policy_document" "cloudfront_full_access" {
  count = "${var.cloudfront_full_access}"

  statement {
    sid = "CloudFrontFullAccessListCertificates"

    actions = [
      "acm:ListCertificates",
    ]

    resources = ["arn:aws:acm:::*"]
  }

  statement {
    sid = "CloudFrontFullAccessListServerCertificates"

    actions = [
      "iam:ListServerCertificates",
    ]

    resources = ["arn:aws:iam:::*"]
  }

  statement {
    sid = "CloudFrontFullAccessWAFListGetWebACL"

    actions = [
      "waf:ListWebACLs",
      "waf:GetWebACL",
    ]

    resources = ["arn:aws:waf:::*"]
  }

  statement {
    sid = "CloudFrontFullAccess"

    actions = [
      "cloudfront:*",
    ]

    resources = ["${var.cloudfront_full_access_resources}"]
  }

  statement {
    sid = "CloudFrontFullAccessListAllMyBuckets"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = ["arn:aws:s3:::*"]
  }
}

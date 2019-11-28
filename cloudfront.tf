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
    sid = "CloudFrontReadOnlyAccess"

    actions = [
      "acm:ListCertificates",
      "cloudfront:Get*",
      "cloudfront:List*",
      "iam:ListServerCertificates",
      "route53:List*",
      "waf:ListWebACLs",
      "waf:GetWebACL",
    ]

    resources = ["${var.cloudfront_read_only_resources}"]
  }
}

data "aws_iam_policy_document" "cloudfront_full_access" {
  count = "${var.cloudfront_full_access}"

  statement {
    sid = "CloudFrontFullAccess"

    actions = [
      "acm:ListCertificates",
      "cloudfront:*",
      "iam:ListServerCertificates",
      "waf:ListWebACLs",
      "waf:GetWebACL",
    ]

    resources = ["${var.cloudfront_full_access_resources}"]
  }

  statement {
    sid = "CloudFrontListAllMyBuckets"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resource = ["arn:aws:s3:::*"]
  }
}

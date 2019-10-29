data "aws_iam_policy_document" "s3_listbuckets" {
  count = "${var.s3_readonly == "1" || var.s3_write == "1" || var.s3_full_access == "1" ? "1" : "0"}"

  statement {
    sid = "S3ListBuckets"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "s3_readonly" {
  count = "${var.s3_readonly}"

  statement {
    sid = "S3ReadAccessBuckets"

    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = "${concat(formatlist("%v", var.s3_read_buckets), formatlist("%v/*", var.s3_read_buckets))}"
  }
}

data "aws_iam_policy_document" "s3_write" {
  count = "${var.s3_write}"

  statement {
    sid = "S3WriteAccessBuckets"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:DeleteObject",
    ]

    resources = "${concat(formatlist("%v", var.s3_write_buckets), formatlist("%v/*", var.s3_write_buckets))}"
  }
}

data "aws_iam_policy_document" "s3_full_access" {
  count = "${var.s3_full_access}"

  statement {
    sid       = "S3FullAccessBuckets"
    actions   = ["s3:*"]
    resources = "${concat(formatlist("%v", var.s3_full_access_buckets), formatlist("%v/*", var.s3_full_access_buckets))}"
  }
}

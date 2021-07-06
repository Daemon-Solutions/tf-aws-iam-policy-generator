variable "pi_full_access" {
  description = "Boolean indicating whether to Provide Full PI RDS access"
  default     = false
}

data "aws_iam_policy_document" "pi_full_access" {
  count = "${var.pi_full_access ? "1" : "0"}"

  statement {
    sid = "PIFullPermissions"

    actions = [
        "pi:DescribeDimensionKeys",
        "pi:GetDimensionKeyDetails",
        "pi:GetResourceMetrics",
    ]
    
    resources = ["*"]
  }
}

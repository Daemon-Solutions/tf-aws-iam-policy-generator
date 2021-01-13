variable "cloudwatch_event_full_access" {
  description = "Boolean indicating whether to give Full Access to CloudWatch Events."
  default     = false
}
variable "cloudwatch_event_full_access_resources" {
  description = "A list of CloudWatch Event resources to which the user has Full Access too."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  count = "${var.cloudwatch_event_full_access}"

  statement {
    sid = "CloudWatchEventsFullAccess"

    actions = [
      "events:*",
    ]

    resources = ["${var.cloudwatch_event_full_access_resources}"]
  }
}

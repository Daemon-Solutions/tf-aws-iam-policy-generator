variable "es_read" {
  description = "Boolean indicating whether to give Read Only access to ES."
  default     = false
}

variable "es_read_only_resources" {
  description = "A list of ES resources which the user has Read Only access too."
  type        = "list"
  default     = []
}

variable "es_full_access" {
  description = "Boolean indicating whether to give Full Access to the ES Resources."
  default     = false
}

variable "es_full_access_resources" {
  description = "A list of ES resources which the user has Full Access too."
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "es_read_only" {
  count = "${var.es_read}"

  statement {
    sid = "ESReadOnlyGetListDescribe"

    actions = [
      "es:Describe*",
      "es:List*",
      "es:Get*"
    ]

    resources = ["${var.es_read_only_resources}"]
  }
}

data "aws_iam_policy_document" "es_full_access" {
  count = "${var.es_full_access}"

  statement {
    sid = "ESFullAccess"

    actions = [
      "es:*",
    ]

    resources = ["${var.es_full_access_resources}"]
  }
}

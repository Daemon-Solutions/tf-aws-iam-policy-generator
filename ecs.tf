variable "ecs_list" {
  description = "Whether to create a policy to allowing listing of ECS Clusters."
  default     = false
}

variable "ecs_read" {
  description = "Whether to create a policy to allow reading of specified ECS Cluster."
  default     = false
}

variable "ecs_write" {
  description = "Whether to grant write access to specified ECS Cluster."
  default     = false
}

variable "ecs_read_cluster" {
  description = "List of ECS to grant read access to"
  type        = "list"
  default     = []
}

variable "ecs_write_cluster" {
  description = "List of ECS to grant write access to"
  type        = "list"
  default     = []
}

data "aws_iam_policy_document" "ecs_list" {
  count = "${var.ecs_list || var.ecs_read || var.ecs_write ? "1" : "0"}"

  statement {
    sid = "ECSList"

    actions = [
      "ecs:Describe*",
      "ecs:List*",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_read" {
  count = "${var.ecs_read}"

  statement {
    sid = "ECSaReadCluster"

    actions = [
      "ecs:Describe*",
      "ecs:List*",
    ]

    resources = ["${var.ecs_read_cluster}"]
  }
}

data "aws_iam_policy_document" "ecs_write" {
  count = "${var.ecs_write}"

  statement {
    sid = "ECSWriteAccess"

    actions = [
      "ecs:Put*",
      "ecs:Update*",
      "ecs:Create*",
      "ecs:Delete*",
      "ecs:Register*",
      "ecs:Run*",
      "ecs:Start*",
      "ecs:Stop*",
      "ecs:Submit*",
    ]

    resources = ["${var.ecs_write_cluster}"]
  }
}
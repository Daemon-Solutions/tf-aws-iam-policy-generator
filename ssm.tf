variable "ssm_parameters_list" {
  description = "Whether to create a policy to allowing listing of Systems Manager Parameter Store Parameters."
  default     = false
}

variable "ssm_parameters_read" {
  description = "Whether to create a policy to allow reading of specified Systems Manager Parameter Store Parameters."
  default     = false
}

variable "ssm_parameters_read_params" {
  description = "List of System Manager Parameter Store Parameters to grant read access to"
  type        = any
  default     = []
}

variable "ssm_parameters_write" {
  description = "Whether to grant write access to specified Systems Manager Parameter Store Parameters."
  default     = false
}

variable "ssm_parameters_write_params" {
  description = "List of System Manager Parameter Store Parameters to grant write access to"
  type        = list(string)
  default     = []
}

variable "ssm_parameters_full_access" {
  description = "Whether to grant full access to the System Manager Parameter Store Parameters."
  default     = false
}

variable "ssm_parameters_full_access_params" {
  description = "List of System Manager Parameter Store Parameters to grant full access access to"
  type        = list(string)
  default     = []
}

data "aws_iam_policy_document" "ssm_parameters_list" {
  count = var.ssm_parameters_list || var.ssm_parameters_read || var.ssm_parameters_write || var.ssm_parameters_full_access ? "1" : "0"

  statement {
    sid = "SSMParameterStoreListAndDescribeParams"

    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameterHistory",
      "ssm:ListTagsForResource",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ssm_parameters_read" {
  count = var.ssm_parameters_read ? 1 : 0

  statement {
    sid = "SSMParametersReadParams"

    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = var.ssm_parameters_read_params
  }
}

data "aws_iam_policy_document" "ssm_parameters_write" {
  count = var.ssm_parameters_write ? 1 : 0

  statement {
    sid = "SSMParametersWriteAccess"

    actions = [
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
      "ssm:LabelParameterVersion",
      "ssm:PutParameter",
    ]

    resources = var.ssm_parameters_write_params
  }
}

data "aws_iam_policy_document" "ssm_parameters_full_access" {
  count = var.ssm_parameters_full_access ? 1 : 0

  statement {
    sid = "SSMParametersFullAccess"

    actions = [
      "ssm:DeleteParameter",
      "ssm:DeleteParameters",
      "ssm:GetParameter",
      "ssm:GetParameter",
      "ssm:GetParameterHistory",
      "ssm:GetParameters",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:LabelParameterVersion",
      "ssm:PutParameter",
    ]

    resources = var.ssm_parameters_full_access_params
  }
}

variable "lambda_list" {
  description = "Whether to create a policy to allowing listing of Lambda functions."
  default     = false
}

variable "lambda_read" {
  description = "Whether to create a policy to allow reading of specified Lambda functions."
  default     = false
}

variable "lambda_read_functions" {
  description = "List of functions to grant read access to"
  type        = "list"
  default     = []
}

variable "lambda_invoke" {
  description = "Whether to grant access to invoke Lambda functions"
  default     = false
}

variable "lambda_invoke_functions" {
  description = "List of functions to grant invoke access to"
  type        = "list"
  default     = []
}

variable "lambda_write" {
  description = "Whether to grant write access to specified Lambda functions."
  default     = false
}

variable "lambda_write_functions" {
  description = "List of functions to grant write access to"
  type        = "list"
  default     = []
}

variable "lambda_full_access" {
  description = "Whether to grant full access to the Lambda."
  default     = false
}

data "aws_iam_policy_document" "lambda_list" {
  count = "${var.lambda_list || var.lambda_read || var.lambda_invoke || var.lambda_write || var.lambda_full_access ? "1" : "0"}"

  statement {
    sid = "LambdaListAndDescribeFunctions"

    actions = [
      "lambda:GetAccountSettings",
      "lambda:ListEventSourceMappings",
      "lambda:ListFunctions",
      "lambda:ListLayerVersions",
      "lambda:ListLayers",
    ]

    resources = ["*"]
  }

  statement {
    sid = "PermissionToListLambdaRoles"

    action = [
      "iam:ListRoles",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda_read" {
  count = "${var.lambda_read}"

  statement {
    sid = "LambdaReadFunctions"

    actions = [
      "lambda:GetAlias",
      "lambda:GetFunction",
      "lambda:GetFunctionConfiguration",
      "lambda:GetPolicy",
      "lambda:ListAliases",
      "lambda:ListTags",
      "lambda:ListVersionsByFunction",
      "lambda:ListVersionsByFunction",
    ]

    resources = ["${var.lambda_read_functions}"]
  }
}

data "aws_iam_policy_document" "lambda_invoke" {
  count = "${var.lambda_invoke}"

  statement {
    sid = "PermissionToInvokeFunction"

    actions = [
      "lambda:InvokeAsync",
      "lambda:InvokeFunction",
    ]

    resources = ["${var.lambda_invoke_functions}"]
  }
}

data "aws_iam_policy_document" "lambda_write" {
  count = "${var.lambda_write}"

  statement {
    sid = "LambdaPermissionToPassRole"

    actions = [
      "iam:PassRole",
    ]

    resources = ["*"]
  }

  statement {
    sid = "LambdaWriteAccess"

    actions = [
      "lambda:AddPermission",
      "lambda:CreateAlias",
      "lambda:CreateEventSourceMapping",
      "lambda:CreateFunction",
      "lambda:DeleteAlias",
      "lambda:DeleteFunction",
      "lambda:DeleteFunctionConcurrency",
      "lambda:EnableReplication",
      "lambda:PublishVersion",
      "lambda:PutFunctionConcurrency",
      "lambda:RemovePermission",
      "lambda:TagResource",
      "lambda:UntagResource",
      "lambda:UpdateAlias",
      "lambda:UpdateEventSourceMapping",
      "lambda:UpdateFunctionCode",
      "lambda:UpdateFunctionConfiguration",
    ]

    resource = ["${var.lambda_write_functions}"]
  }
}

data "aws_iam_policy_document" "lambda_full_access" {
  count = "${var.lambda_full_access}"

  statement {
    sid = "LambdaFullAccess"

    action = [
      "lambda:*",
    ]

    resources = ["*"]
  }
}
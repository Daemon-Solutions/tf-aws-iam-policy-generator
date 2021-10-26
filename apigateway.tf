variable "apigateway_read" {
  description = "Boolean indicating whether to create a policy to allow read only access to APIGateway APIs"
  default     = false
}

variable "apigateway_read_apis" {
  description = "A list of APIGateway APIs to allow reading from"
  type        = list(string)
  default     = []
}

variable "apigateway_post" {
  description = "Boolean indicating whether to create a policy to allow post access to APIGateway APIs"
  default     = false
}

variable "apigateway_post_apis" {
  description = "A list of APIGateway APIs to allow posting to"
  type        = list(string)
  default     = []
}

variable "apigateway_write" {
  description = "Boolean indicating whether to create a policy to allow write access to APIGateway APIs"
  type        = string
  default     = false
}

variable "apigateway_write_apis" {
  description = "A list of APIGateway APIs to allow writing to"
  type        = list(string)
  default     = []
}

variable "apigateway_invoke" {
  description = "Boolean indicating whether to allow Invoke and Manage to APIGateway"
  type        = string
  default     = false
}

variable "apigateway_invoke_apis" {
  description = "A list of APIGateway APIs to allow Invoke and Manage"
  type        = list(string)
  default     = []
}

variable "apigateway_full_access" {
  description = "Boolean indicating whether to create a policy to allow full access to APIGateway APIs"
  type        = string
  default     = false
}

variable "apigateway_full_access_apis" {
  description = "A list of APIGateway APIs to allow full access to"
  type        = list(string)
  default     = []
}

data "aws_iam_policy_document" "apigateway_read" {
  count = var.apigateway_read ? 1 : 0

  statement {
    sid = "APIGatewayReadOnlyAccessAPIs"

    actions = [
      "apigateway:GET",
    ]

    resources = var.apigateway_read_apis
  }
}

data "aws_iam_policy_document" "apigateway_post" {
  count = var.apigateway_post ? 1 : 0

  statement {
    sid = "APIGatewayPostAccessAPIs"

    actions = [
      "apigateway:POST",
    ]

    resources = var.apigateway_post_apis
  }
}

data "aws_iam_policy_document" "apigateway_write" {
  count = var.apigateway_write ? 1 : 0

  statement {
    sid = "APIGatewayWriteAccessAPIs"

    actions = [
      "apigateway:DELETE",
      "apigateway:PATCH",
      "apigateway:POST",
      "apigateway:PUT",
      "apigateway:SetWebACL",
      "apigateway:UpdateRestApiPolicy",
    ]

    resources = var.apigateway_write_apis
  }
}

data "aws_iam_policy_document" "apigateway_invoke" {
  count = var.apigateway_invoke ? 1 : 0

  statement {
    sid = "InvokeAPI"

    actions = [
      "execute-api:Invoke",
      "execute-api:ManageConnections",
    ]

    resources = var.apigateway_invoke_apis
  }
}

data "aws_iam_policy_document" "apigateway_full_access" {
  count = var.apigateway_full_access ? 1 : 0

  statement {
    sid = "APIGatewayFullAccessAPIs"

    actions = [
      "apigateway:*",
    ]

    resources = var.apigateway_full_access_apis
  }
}

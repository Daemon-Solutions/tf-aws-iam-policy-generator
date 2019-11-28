variable "iam_change_password" {
  description = "Boolean indicating whether to give the policy the IAM:ChangePassword permission"
  default     = false
}

variable "iam_get_account_password_policy" {
  description = "Boolean indicating whether to give the policy the IAM:GetAccountPasswordPolicy permission"
  default     = false
}

variable "iam_manage_access_key" {
  description = "Boolean indicating whether to give the policy the IAM:*AccessKey* permission"
  default     = false
}

variable "iam_manage_mfa" {
  description = "Boolean indicating whether to give an IAM user the permissions to self-manage their MFA"
  default = false
}

variable "iam_list_users" {
  description = "Boolean indicating whether to give the permission to list all IAM User"
  default = false
}

variable "iam_list_groups_for_user" {
  description = "Boolean indicating whether to give an IAM user the permissions to view their IAM Groups"
  default = false
}

variable "iam_read" {
  description = "Boolean indicating whether to give an IAM user the permissions to view IAM in the AWS Console"
  default = false
}

variable "iam_read_only_resources" {
  description = "A list of resources which has Read Only access to IAM"
  type = "list"
  default = []
}

data "aws_iam_policy_document" "iam_read_only" {
  count = "${var.iam_read}"

  statement {
    sid = "IAMReadOnly"

    actions = [
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:SimulateCustomPolicy",
      "iam:SimulatePrincipalPolicy"
    ]

    resources = ["${var.iam_read_only_resources}"]
  }
}

data "aws_iam_policy_document" "iam_list_users" {
  count = "${var.iam_list_users}"

  statement {
    sid = "IAMListUsers"

    actions = [
      "iam:ListUsers",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_list_groups_for_user" {
  count = "${var.iam_list_groups_for_user}"

  statement {
    sid = "IAMListGroupsForUser"

    actions = [
      "iam:ListGroupsForUser",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_change_password" {
  count = "${var.iam_change_password}"

  statement {
    sid = "IAMChangePassword"

    actions = [
      "iam:ChangePassword",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_get_account_password_policy" {
  count = "${var.iam_get_account_password_policy}"

  statement {
    sid = "IAMGetAccountPasswordPolicy"

    actions = [
      "iam:GetAccountPasswordPolicy",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_manage_access_key" {
  count = "${var.iam_manage_access_key}"

  statement {
    sid = "IAMManageAccessKey"

    actions = [
      "iam:*AccessKey*",
    ]

    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

data "aws_iam_policy_document" "iam_manage_mfa" {
  count = "${var.iam_manage_mfa}"

  statement {
    # Allow Users All Actions For Credentials
    sid = "IAMMFAAllowAllActionsForCredentials"

    actions = [
      "iam:ListAttachedUserPolicies",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:*LoginProfile",
      "iam:*AccessKey*",
      "iam:*SigningCertificate*",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement {
    # Allow Users To List Users In The Console
    sid = "IAMMFAListUsersInTheConsole"

    actions = [
      "iam:ListUsers",
    ]

    resources = [
      "arn:aws:iam::*:user/*",
    ]
  }

  statement {
    # Allow Users To List Own Groups In The Console
    sid = "IAMMFAListGroupsForUser"

    actions = [
      "iam:ListGroupsForUser",
    ]

    resources = [
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement {
    # Allow Users To Create Their Own Virtual MFA Device
    sid = "IAMMFAUserCreateTheirOwnVirtualMFADevice"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = [
      "arn:aws:iam::*:mfa/$${aws:username}",
      "arn:aws:iam::*:user/$${aws:username}",
    ]
  }

  statement {
    # Allow Users To List Virtual MFA Devices
    sid = "IAMMFAUserListVirtualMFADevices"

    actions = [
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
    ]

    resources = [
      "arn:aws:iam::*:*",
    ]
  }
}

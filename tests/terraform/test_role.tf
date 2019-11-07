resource "aws_iam_role" "test_role" {
  assume_role_policy = "${data.aws_iam_policy_document.test_role_assume_policy.json}"
}

data "aws_iam_policy_document" "test_role_assume_policy" {
  statement {
    sid = "TestRoleAssumePolicy"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/BashtonAdministrator"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "test_policy" {
  count      = "${length(module.test_user_iam_policy.policies)}"
  role       = "${aws_iam_role.test_role.id}"
  policy_arn = "${element(aws_iam_policy.user_policies.*.arn, count.index)}"
}

output "test_role_arn" {
  value = "${aws_iam_role.test_role.arn}"
}

variable "managed_policy_arns" {
  description = "A list of existing policy document ARNs to merge into the created policies. You can specify policy versions by appending ':VersionId' e.g. ':v1' to the ARN."
  default     = []
}

data "external" "policy_fetcher" {
  program = ["python3", "${path.module}/policy_fetcher.py"]

  query = {
    policy_arns = "${jsonencode(var.managed_policy_arns)}"
  }
}

locals {
  b64_output_policies = "${split(",", lookup(data.external.policy_fetcher.result, "b64_policies"))}"
}

data "template_file" "managed_policies" {
  count = "${lookup(data.external.policy_fetcher.result, "policy_count")}"

  template = "$${value}"

  vars = {
    value = "${base64decode(element(local.b64_output_policies, count.index))}"
  }
}

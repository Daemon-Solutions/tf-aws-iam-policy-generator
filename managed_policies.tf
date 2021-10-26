variable "managed_policies" {
  description = "Boolean indicating whether to allow Invoke and Manage to APIGateway."
  default     = true
}

variable "managed_policy_arns" {
  description = "A list of existing policy document ARNs to merge into the created policies. You can specify policy versions by appending ':VersionId' e.g. ':v1' to the ARN."
  default     = []
}

data "external" "policy_fetcher" {
  count   = var.managed_policies ? 1 : 0
  program = ["python3", "${path.module}/policy_fetcher.py"]

  query = {
    policy_arns = jsonencode(var.managed_policy_arns)
  }
}

locals {
  b64_output_policies = split(",", data.external.policy_fetcher[0].result["b64_policies"])
}

data "template_file" "managed_policies" {
  count = data.external.policy_fetcher[0].result["policy_count"]

  template = "$${value}"

  vars = {
    value = base64decode(element(local.b64_output_policies, count.index))
  }
}

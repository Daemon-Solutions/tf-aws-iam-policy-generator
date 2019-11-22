variable "custom_policies" {
  description = "Boolean indicating whether to include custom IAM policies."
  default     = false
}

variable "custom_policies_list" {
  description = "A list of custom IAM policy documents in JSON form to include as part of the condensed IAM policies."
  type        = "list"
  default     = []
}
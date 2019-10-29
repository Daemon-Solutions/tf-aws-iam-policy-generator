variable "s3_readonly" {
  description = "Bit indicating whether to create a policy to allow List/Get objects in a bucket"
  type        = "string"
  default     = "0"
}

variable "s3_read_buckets" {
  description = "A list of S3 buckets to create allow access to via the generated policies"
  type        = "list"
  default     = []
}

variable "s3_write" {
  description = "Bit indicating whether to create a policy to allow write access to a buckets objects and their ACLs."
  type        = "string"
  default     = "0"
}

variable "s3_write_buckets" {
  description = "A list of S3 buckets to create policies to allow writing to"
  type        = "list"
  default     = []
}

variable "s3_full_access" {
  description = "Bit indicating whether to create a policy to allow full access to a bucket (including modifying and deleting the bucket)"
  type        = "string"
  default     = "0"
}

variable "s3_full_access_buckets" {
  description = "A list of S3 buckets to create policies to allow full access to"
  type        = "list"
  default     = []
}

variable "dynamodb_read" {
  description = "Bit indicating whether to create a policy to allow read only access to dynamodb tables"
  type        = "string"
  default     = "0"
}

variable "dynamodb_read_tables" {
  description = "A list of dynamodb tables to allow reading from"
  type        = "list"
  default     = []
}

variable "dynamodb_write" {
  description = "Bit indicating whether to create a policy to allow write access to dynamodb tables"
  type        = "string"
  default     = "0"
}

variable "dynamodb_write_tables" {
  description = "A list of dynamodb tables to allow writing to"
  type        = "list"
  default     = []
}

variable "policy_type" {
  type        = "string"
  description = "The type of policy to generate. Valid types are: user, group, role. This is used to determine the maximum allowed length of the policy."
}

variable "policy_type_length_limit" {
  type = "map"

  default = {
    group = 10240
    role  = 5120
    user  = 2048
  }
}

variable "policy_version" {
  type    = "string"
  default = "2012-10-17"
}

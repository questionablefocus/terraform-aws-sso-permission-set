variable "name" {
  type        = string
  description = "The name of the permission set"
}

variable "session_duration" {
  type        = string
  description = "The length of time that the application user sessions are valid in the ISO-8601 standard"
  default     = "PT1H"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of managed policy ARNs to attach to the permission set"
  default     = []
}

variable "inline_policy" {
  type        = string
  description = "The IAM policy document to use as the inline policy for the permission set"
  default     = null
}

variable "instance_arn" {
  type        = string
  description = "The ARN of the SSO Instance"
}

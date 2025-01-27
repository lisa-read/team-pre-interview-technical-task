variable "prefix" {
  description = "Prefix for SQS queues"
  type        = string
}

variable "suffix" {
  description = "Additional suffix for the SQS queue names"
  type        = string
  default     = "" # Optional: Default to an empty string if suffix isn't provided
}
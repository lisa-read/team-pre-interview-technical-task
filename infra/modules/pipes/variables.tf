variable "source_queues" {
  description = "Map of pipe types to their source queue ARNs"
  type = object({
    basket   = string
    checkout = string
  })
}

variable "target_queue_arn" {
  description = "ARN of the target queue"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "role_arn" {
  description = "ARN of the IAM role for the pipe"
  type        = string
}
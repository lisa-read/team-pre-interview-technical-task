variable "rule_name" {
  description = "Name of the CloudWatch event rule"
  type        = string
}

variable "event_bus_name" {
  description = "Name of the EventBridge event bus"
  type        = string
}

variable "event_pattern" {
  description = "Event pattern for the rule"
  type = object({
    source      = list(string)
    detail-type = list(string)
    detail = object({
      eventSource = list(string)
      eventName   = list(string)
      resources   = list(string)
    })
  })
}

variable "target_arn" {
  description = "ARN of the target (e.g., SQS queue)"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for EventBridge to access the target"
  type        = string
}

variable "prefix" {
  description = "Resource prefix"
  type        = string
}

variable "event_bus" {
  description = "EventBridge bus ARN"
  type        = string
}

variable "sqs_target" {
  description = "SQS queue ARN"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "source_queues" {
  description = "Map of pipe types to their source queue ARNs"
  type = object({
    basket   = string
    checkout = string
  })
}

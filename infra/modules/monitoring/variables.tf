variable "prefix" {
  description = "Prefix to be used for all alarm names"
  type        = string
}

variable "aws_region" {
  description = "AWS region for the dashboard"
  type        = string
}

variable "sns_alarm_topic" {
  description = "ARN of the SNS topic for alarm notifications"
  type        = string
}

variable "queue_names" {
  description = "Map of queue types to their names"
  type = object({
    dead_letter_queue = string
    purchase_events   = string
  })
}

variable "pipe_names" {
  description = "Map of pipe types to their names"
  type = object({
    basket   = string
    checkout = string
  })
}

variable "alarm_settings" {
  description = "Default settings for alarms"
  type = object({
    sqs_evaluation_periods  = number
    sqs_period              = number
    sqs_threshold           = number
    pipe_evaluation_periods = number
    pipe_period             = number
    pipe_duration_threshold = number
  })
  default = {
    sqs_evaluation_periods  = 3
    sqs_period              = 300
    sqs_threshold           = 10
    pipe_evaluation_periods = 2
    pipe_period             = 300
    pipe_duration_threshold = 10000
  }
}

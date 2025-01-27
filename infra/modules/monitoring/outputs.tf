output "dlq_alarm_arn" {
  description = "ARN of the DLQ CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.dlq_messages.arn
}

output "purchase_events_alarm_arn" {
  description = "ARN of the purchase events CloudWatch alarm"
  value       = aws_cloudwatch_metric_alarm.purchase_events.arn
}

output "pipe_alarms" {
  description = "Map of pipe alarm ARNs"
  value = {
    execution_failed = {
      for k, v in aws_cloudwatch_metric_alarm.pipe_execution_failed : k => v.arn
    }
    throttled = {
      for k, v in aws_cloudwatch_metric_alarm.pipe_throttled : k => v.arn
    }
    duration = {
      for k, v in aws_cloudwatch_metric_alarm.pipe_duration : k => v.arn
    }
    target_failed = {
      for k, v in aws_cloudwatch_metric_alarm.pipe_target_failed : k => v.arn
    }
  }
}

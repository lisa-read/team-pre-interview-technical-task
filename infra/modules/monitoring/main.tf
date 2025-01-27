# SQS Monitors
resource "aws_cloudwatch_metric_alarm" "dlq_messages" {
  alarm_name          = "${var.prefix}-dlq-messages"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_settings.sqs_evaluation_periods
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = var.alarm_settings.sqs_period
  statistic           = "Average"
  threshold           = var.alarm_settings.sqs_threshold
  alarm_description   = "This metric monitors DLQ messages"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    QueueName = var.queue_names.dead_letter_queue
  }
}

resource "aws_cloudwatch_metric_alarm" "purchase_events" {
  alarm_name          = "${var.prefix}-purchase-events"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_settings.sqs_evaluation_periods
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = var.alarm_settings.sqs_period
  statistic           = "Average"
  threshold           = var.alarm_settings.sqs_threshold
  alarm_description   = "This metric monitors purchase events queue"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    QueueName = var.queue_names.purchase_events
  }
}

# Pipe Monitoring

# Pipe Failures
resource "aws_cloudwatch_metric_alarm" "pipe_execution_failed" {
  for_each = var.pipe_names

  alarm_name          = "${var.prefix}-${each.key}-pipe-execution-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_settings.pipe_evaluation_periods
  metric_name         = "ExecutionFailed"
  namespace           = "AWS/Pipes"
  period              = var.alarm_settings.pipe_period
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alert when pipe execution fails"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    PipeName = each.value
  }
}

# Pipe Throttling
resource "aws_cloudwatch_metric_alarm" "pipe_throttled" {
  for_each = var.pipe_names

  alarm_name          = "${var.prefix}-${each.key}-pipe-throttled"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "ExecutionThrottled"
  namespace           = "AWS/Pipes"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alert when pipe is being throttled"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    PipeName = each.value
  }
}

# Pipe Duration 
resource "aws_cloudwatch_metric_alarm" "pipe_duration" {
  for_each = var.pipe_names

  alarm_name          = "${var.prefix}-${each.key}-pipe-high-duration"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Duration"
  namespace           = "AWS/Pipes"
  period              = "300"
  statistic           = "Average"
  threshold           = "10000" # 10 seconds in milliseconds
  alarm_description   = "Alert when pipe execution takes too long"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    PipeName = each.value
  }
}

# Pipe Target failures
resource "aws_cloudwatch_metric_alarm" "pipe_target_failed" {
  for_each = var.pipe_names

  alarm_name          = "${var.prefix}-${each.key}-pipe-target-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "TargetStageFailed"
  namespace           = "AWS/Pipes"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Alert when pipe target stage fails"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    PipeName = each.value
  }
}

# Pipe no events processed timing
resource "aws_cloudwatch_metric_alarm" "pipe_no_events" {
  for_each = var.pipe_names

  alarm_name          = "${var.prefix}-${each.key}-pipe-no-events"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "12" # 1 hour (12 x 5 minutes)
  metric_name         = "EventCount"
  namespace           = "AWS/Pipes"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Alert when no events are processed for 1 hour"
  alarm_actions       = [var.sns_alarm_topic]

  dimensions = {
    PipeName = each.value
  }
}


# Cloudwatch dashboard

resource "aws_cloudwatch_dashboard" "pipes_dashboard" {
  dashboard_name = "${var.prefix}-pipes-dashboard"

  dashboard_body = jsonencode({
    widgets = concat(
      # Pipe Metrics
      flatten([
        for metric, config in {
          "EventCount"          = { title = "Events Processed", y_pos = 0 },
          "ExecutionFailed"    = { title = "Failed Executions", y_pos = 0 },
          "ExecutionThrottled" = { title = "Throttled Executions", y_pos = 6 },
          "Duration"            = { title = "Execution Duration", y_pos = 6 },
          "TargetStageFailed"   = { title = "Target Stage Failures", y_pos = 12 }
          } : {
          type   = "metric",
          x      = contains(["EventCount", "ExecutionThrottled", "TargetStageFailed"], metric) ? 0 : 12,
          y      = config.y_pos,
          width  = 12,
          height = 6,
          properties = {
            metrics = [
              ["AWS/Pipes", metric, "PipeName", var.pipe_names.basket],
              [".", ".", ".", var.pipe_names.checkout]
            ],
            view    = "timeSeries",
            stacked = false,
            region  = var.aws_region,
            title   = config.title,
            period  = 300
          }
        }
      ]),
      # SQS Metrics
      [
        {
          type   = "metric",
          x      = 12,
          y      = 12,
          width  = 12,
          height = 6,
          properties = {
            metrics = [
              ["AWS/SQS", "ApproximateNumberOfMessagesVisible", "QueueName", var.queue_names.purchase_events],
              [".", ".", ".", var.queue_names.dead_letter_queue]
            ],
            view    = "timeSeries",
            stacked = false,
            region  = var.aws_region,
            title   = "Queue Message Count",
            period  = 300
          }
        },
        {
          type   = "metric",
          x      = 0,
          y      = 18,
          width  = 12,
          height = 6,
          properties = {
            metrics = [
              ["AWS/SQS", "ApproximateAgeOfOldestMessage", "QueueName", var.queue_names.purchase_events],
              [".", ".", ".", var.queue_names.dead_letter_queue]
            ],
            view    = "timeSeries",
            stacked = false,
            region  = var.aws_region,
            title   = "Age of Oldest Message",
            period  = 300
          }
        },
        {
          type   = "metric",
          x      = 12,
          y      = 18,
          width  = 12,
          height = 6,
          properties = {
            metrics = [
              ["AWS/SQS", "NumberOfMessagesReceived", "QueueName", var.queue_names.purchase_events],
              [".", "NumberOfMessagesSent", ".", "."],
              [".", "NumberOfMessagesReceived", ".", var.queue_names.dead_letter_queue],
              [".", "NumberOfMessagesSent", ".", "."]
            ],
            view    = "timeSeries",
            stacked = false,
            region  = var.aws_region,
            title   = "Messages Received/Sent",
            period  = 300
          }
        }
      ]
    )
  })
}



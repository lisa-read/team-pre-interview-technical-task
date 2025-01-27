resource "aws_sqs_queue" "queue" {
  for_each = var.sns_topics

  name = "${var.prefix}-${each.key}-queue"
}

resource "aws_sns_topic_subscription" "sns_to_sqs" {
  for_each = var.sns_topics

  topic_arn = each.value
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue[each.key].arn
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  for_each = var.sns_topics

  queue_url = aws_sqs_queue.queue[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.queue[each.key].arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = each.value
          }
        }
      }
    ]
  })
}

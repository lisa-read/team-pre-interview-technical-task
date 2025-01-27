resource "aws_sqs_queue" "dlq" {
  name                    = "${var.prefix}-${var.suffix}-dlq"
  sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "queue" {
  name                    = "${var.prefix}-${var.suffix}"
  sqs_managed_sse_enabled = true
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 3
  })
}
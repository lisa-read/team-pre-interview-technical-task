# IAM Role for Pipes
resource "aws_iam_role" "pipe_role" {
  name = "${var.prefix}-eventbridge-pipe-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "pipes.amazonaws.com"
      }
    }]
  })
}

# IAM Policy for Pipes
resource "aws_iam_role_policy" "pipe_policy" {
  name = "${var.prefix}-eventbridge-pipe-policy"
  role = aws_iam_role.pipe_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ListQueues",
          "sqs:GetQueueUrl"
        ]
        Resource = concat(
          [for queue in var.source_queues : queue],
          [var.sqs_target]
        )
      },
      {
        Effect   = "Allow"
        Action   = ["events:PutEvents"]
        Resource = [var.event_bus]
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
        }
      }
    ]
  })
}

# IAM Role for EventBridge-to-SQS
resource "aws_iam_role" "eventbridge_role" {
  name = "${var.prefix}-eventbridge-to-sqs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

# IAM Policy for EventBridge-to-SQS
resource "aws_iam_role_policy" "eventbridge_policy" {
  name = "${var.prefix}-eventbridge-to-sqs-policy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["sqs:SendMessage"]
      Resource = [var.sqs_target]
    }]
  })
}


resource "aws_pipes_pipe" "pipe" {
  for_each = var.source_queues

  name     = "${var.prefix}-${each.key}-pipe"
  role_arn = var.role_arn

  source = each.value

  target = var.target_queue_arn
}


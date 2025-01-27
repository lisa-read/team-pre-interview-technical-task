resource "aws_cloudwatch_event_rule" "rule" {
  name           = var.rule_name
  event_bus_name = var.event_bus_name

  event_pattern = jsonencode(var.event_pattern)
}

resource "aws_cloudwatch_event_target" "target" {
  rule           = aws_cloudwatch_event_rule.rule.name
  event_bus_name = var.event_bus_name
  target_id      = "SendToSQS"
  arn            = var.target_arn
}



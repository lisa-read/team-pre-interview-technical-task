output "pipe_role_arn" {
  value = aws_iam_role.pipe_role.arn
}

output "eventbridge_role_arn" {
  value = aws_iam_role.eventbridge_role.arn
}
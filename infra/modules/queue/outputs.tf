output "queue_arn" {
  value = aws_sqs_queue.queue.arn
}

output "dlq_arn" {
  value = aws_sqs_queue.dlq.arn
}

output "queue_name" {
  value = aws_sqs_queue.queue.name
}

output "dlq_name" {
  value = aws_sqs_queue.dlq.name
}
output "queue_arns" {
  description = "Map of queue types to their ARNs"
  value = {
    for k, v in aws_sqs_queue.queue : k => v.arn
  }
}

output "queue_urls" {
  description = "Map of queue types to their URLs"
  value = {
    for k, v in aws_sqs_queue.queue : k => v.id
  }
}

output "queue_names" {
  description = "Map of queue types to their names"
  value = {
    for k, v in aws_sqs_queue.queue : k => v.name
  }
}

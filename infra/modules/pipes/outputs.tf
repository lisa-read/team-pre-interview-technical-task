output "pipe_names" {
  description = "Map of created pipe names"
  value = {
    for k, v in aws_pipes_pipe.pipe : k => v.name
  }
}

output "pipe_arns" {
  description = "Map of created pipe ARNs"
  value = {
    for k, v in aws_pipes_pipe.pipe : k => v.arn
  }
}

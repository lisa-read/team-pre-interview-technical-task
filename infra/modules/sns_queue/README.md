<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic_subscription.sns_to_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sqs_queue.queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.sqs_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delay_seconds"></a> [delay\_seconds](#input\_delay\_seconds) | The time in seconds that the delivery of all messages in the queue will be delayed | `number` | `0` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | The limit of how many bytes a message can contain | `number` | `262144` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | The number of seconds Amazon SQS retains a message | `number` | `345600` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be used for resource names | `string` | n/a | yes |
| <a name="input_receive_wait_time_seconds"></a> [receive\_wait\_time\_seconds](#input\_receive\_wait\_time\_seconds) | The time for which a ReceiveMessage call will wait for a message to arrive | `number` | `0` | no |
| <a name="input_sns_topics"></a> [sns\_topics](#input\_sns\_topics) | Map of queue types to their SNS topic ARNs | <pre>object({<br/>    basket   = string<br/>    checkout = string<br/>  })</pre> | n/a | yes |
| <a name="input_visibility_timeout_seconds"></a> [visibility\_timeout\_seconds](#input\_visibility\_timeout\_seconds) | The visibility timeout for the queue | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_queue_arns"></a> [queue\_arns](#output\_queue\_arns) | Map of queue types to their ARNs |
| <a name="output_queue_names"></a> [queue\_names](#output\_queue\_names) | Map of queue types to their names |
| <a name="output_queue_urls"></a> [queue\_urls](#output\_queue\_urls) | Map of queue types to their URLs |
<!-- END_TF_DOCS -->
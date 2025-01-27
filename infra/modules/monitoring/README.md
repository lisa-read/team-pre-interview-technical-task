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
| [aws_cloudwatch_dashboard.pipes_dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_cloudwatch_metric_alarm.dlq_messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.pipe_duration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.pipe_execution_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.pipe_no_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.pipe_target_failed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.pipe_throttled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.purchase_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_settings"></a> [alarm\_settings](#input\_alarm\_settings) | Default settings for alarms | <pre>object({<br/>    sqs_evaluation_periods  = number<br/>    sqs_period              = number<br/>    sqs_threshold           = number<br/>    pipe_evaluation_periods = number<br/>    pipe_period             = number<br/>    pipe_duration_threshold = number<br/>  })</pre> | <pre>{<br/>  "pipe_duration_threshold": 10000,<br/>  "pipe_evaluation_periods": 2,<br/>  "pipe_period": 300,<br/>  "sqs_evaluation_periods": 3,<br/>  "sqs_period": 300,<br/>  "sqs_threshold": 10<br/>}</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for the dashboard | `string` | n/a | yes |
| <a name="input_pipe_names"></a> [pipe\_names](#input\_pipe\_names) | Map of pipe types to their names | <pre>object({<br/>    basket   = string<br/>    checkout = string<br/>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be used for all alarm names | `string` | n/a | yes |
| <a name="input_queue_names"></a> [queue\_names](#input\_queue\_names) | Map of queue types to their names | <pre>object({<br/>    dead_letter_queue = string<br/>    purchase_events   = string<br/>  })</pre> | n/a | yes |
| <a name="input_sns_alarm_topic"></a> [sns\_alarm\_topic](#input\_sns\_alarm\_topic) | ARN of the SNS topic for alarm notifications | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dlq_alarm_arn"></a> [dlq\_alarm\_arn](#output\_dlq\_alarm\_arn) | ARN of the DLQ CloudWatch alarm |
| <a name="output_pipe_alarms"></a> [pipe\_alarms](#output\_pipe\_alarms) | Map of pipe alarm ARNs |
| <a name="output_purchase_events_alarm_arn"></a> [purchase\_events\_alarm\_arn](#output\_purchase\_events\_alarm\_arn) | ARN of the purchase events CloudWatch alarm |
<!-- END_TF_DOCS -->
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
| [aws_cloudwatch_event_rule.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_event_bus_name"></a> [event\_bus\_name](#input\_event\_bus\_name) | Name of the EventBridge event bus | `string` | n/a | yes |
| <a name="input_event_pattern"></a> [event\_pattern](#input\_event\_pattern) | Event pattern for the rule | <pre>object({<br/>    source      = list(string)<br/>    detail-type = list(string)<br/>    detail = object({<br/>      eventSource = list(string)<br/>      eventName   = list(string)<br/>      resources   = list(string)<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | IAM role ARN for EventBridge to access the target | `string` | n/a | yes |
| <a name="input_rule_name"></a> [rule\_name](#input\_rule\_name) | Name of the CloudWatch event rule | `string` | n/a | yes |
| <a name="input_target_arn"></a> [target\_arn](#input\_target\_arn) | ARN of the target (e.g., SQS queue) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_event_rule_name"></a> [event\_rule\_name](#output\_event\_rule\_name) | n/a |
<!-- END_TF_DOCS -->
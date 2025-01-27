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
| [aws_iam_role.eventbridge_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.pipe_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.eventbridge_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.pipe_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | AWS account ID | `string` | n/a | yes |
| <a name="input_event_bus"></a> [event\_bus](#input\_event\_bus) | EventBridge bus ARN | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resource prefix | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_sns_topics"></a> [sns\_topics](#input\_sns\_topics) | List of SNS topic ARNs | `list(string)` | n/a | yes |
| <a name="input_sqs_target"></a> [sqs\_target](#input\_sqs\_target) | SQS queue ARN | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eventbridge_role_arn"></a> [eventbridge\_role\_arn](#output\_eventbridge\_role\_arn) | n/a |
| <a name="output_pipe_role_arn"></a> [pipe\_role\_arn](#output\_pipe\_role\_arn) | n/a |
<!-- END_TF_DOCS -->
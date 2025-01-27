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
| [aws_pipes_pipe.pipe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/pipes_pipe) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the pipe | `string` | n/a | yes |
| <a name="input_origin"></a> [origin](#input\_origin) | Source/Origin ARN for the pipe | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | IAM role ARN for the pipe | `string` | n/a | yes |
| <a name="input_target"></a> [target](#input\_target) | Target ARN for the pipe | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipe_name"></a> [pipe\_name](#output\_pipe\_name) | n/a |
<!-- END_TF_DOCS -->
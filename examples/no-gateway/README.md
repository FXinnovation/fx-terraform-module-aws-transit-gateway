# No Transit Gateway

Use the module but without creating any gateway. Useful to replace the lack of “count” with modules.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| access\_key | n/a | `any` | n/a | yes |
| secret\_key | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| association\_default\_route\_table\_id | n/a |
| id | n/a |
| owner\_id | n/a |
| propagation\_default\_route\_table\_id | n/a |
| resource\_share\_id | n/a |
| vpc\_attachment\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Standard Transit Gateway

Creates a Transit Gateway with a Resource Share.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_key |  | string | n/a | yes |
| secret\_key |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| association\_default\_route\_table\_id |  |
| id |  |
| owner\_id |  |
| propagation\_default\_route\_table\_id |  |
| resource\_share\_id |  |
| vpc\_attachment\_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

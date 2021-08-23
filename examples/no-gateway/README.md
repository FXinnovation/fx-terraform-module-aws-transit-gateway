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
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 2.18 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_no_gateway"></a> [no\_gateway](#module\_no\_gateway) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | n/a | `any` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_association_default_route_table_id"></a> [association\_default\_route\_table\_id](#output\_association\_default\_route\_table\_id) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | n/a |
| <a name="output_propagation_default_route_table_id"></a> [propagation\_default\_route\_table\_id](#output\_propagation\_default\_route\_table\_id) | n/a |
| <a name="output_resource_share_id"></a> [resource\_share\_id](#output\_resource\_share\_id) | n/a |
| <a name="output_vpc_attachment_id"></a> [vpc\_attachment\_id](#output\_vpc\_attachment\_id) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

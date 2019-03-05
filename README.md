# Module AWS Transit Gateway

Creates a Transit Gateway.

This module works for a simple Transit Gateway creation.
It also creat a VPC attachment, a shared resource for the Transit Gateway and update routes to point to the Transit Gateway.
For more features and use case, make a PR.

Note: the Transit Gateway share resource acceptance, the VPC attachment and route propagation for the **client account** is not implemented in this module.
For the following reasons:
- With AWS provider 1.59 automated resource acceptance is not available.
- With terraform 0.11.X, VPC attachment in client accounts is not idempotent and will raise an error on subsequent calls.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attachement\_subnet\_ids | Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to put the Transit Gateway. | list | `[]` | no |
| attachement\_tags | Tags of the VPC attachement of the Transit Gateway. | map | `{}` | no |
| description | Description of the Transit Gateway. | string | n/a | yes |
| name | Name of the Transit Gateway. | string | n/a | yes |
| resource\_share\_account\_ids | Ids of the account where the Transit Gateway should be shared. | list | `[]` | no |
| resource\_share\_allow\_external\_principals | Whether or not to allow external principals for the Resource Share for the Transit Gateway. | string | `"true"` | no |
| resource\_share\_create | Whether or not to create a Resource Share for the Transit Gateway. This value cannot be computed automatically from other variables in Terraform 0.11.X. | string | `"false"` | no |
| resource\_share\_name | Name of the Resource Share for the Transit Gateway. | string | n/a | yes |
| resource\_share\_tags | Tags of the Resource Share for the Transit Gateway. | map | `{}` | no |
| resource\_share\_tags | Tags of the Resource Share for the Transit Gateway. | map | `{}` | no |
| route\_attached\_vpc\_cidrs | All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. | list | `[]` | no |
| route\_cidrs | All the CIDRs for the Transit Gateway route table. Note that the VPCs CIDR (for the current VPC and the attached VPCs) will be automatically propagated via VPC attachement and thus should not be in this list. | list | `[]` | no |
| tags | Tags of the Transit Gateway. | map | `{}` | no |
| vpc\_id | Id of the VPC where to create the Transit Gateway. | string | n/a | yes |
| vpc\_route\_ids | All the routes of the current VPC that should be aware of the sub accounts attached to the Transit Gateway. | list | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| cidr\_block |  |
| id |  |
| igw\_id |  |
| nat\_public\_ips |  |
| natgw\_ids |  |
| private\_route\_table\_ids |  |
| private\_subnets |  |
| public\_route\_table\_ids |  |
| public\_subnets |  |
| sg\_web\_access\_id |  |
| transit\_gateway\_arn |  |
| transit\_gateway\_association\_default\_route\_table\_id |  |
| transit\_gateway\_id |  |
| transit\_gateway\_owner\_id |  |
| transit\_gateway\_propagation\_default\_route\_table\_id |  |
| transit\_gateway\_resource\_share\_id |  |
| transit\_gateway\_vpc\_attachment\_id |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

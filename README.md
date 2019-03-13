# Module AWS Transit Gateway

Creates a Transit Gateway.

This module works for a simple Transit Gateway creation.
It also creat a VPC attachment, a shared resource for the Transit Gateway and update routes to point to the Transit Gateway.
For more features and use case, make a PR.

Note: the Transit Gateway share resource acceptance, the VPC attachment and route propagation for the **client account** is not implemented in this module.
For the following reasons:
- With AWS provider 1.59 automated Resource Share acceptance is not available.
- With terraform 0.11.X, VPC attachment in client accounts is not idempotent and will raise an error on subsequent calls.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attachement\_subnet\_ids | Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to put the Transit Gateway. | list | `[]` | no |
| attachement\_tags | Tags of the VPC attachement of the Transit Gateway. | map | `{}` | no |
| description | Description of the Transit Gateway. | string | `""` | no |
| name | Name of the Transit Gateway. | string | `""` | no |
| resource\_share\_account\_ids | Ids of the account where the Transit Gateway should be shared. | list | `[]` | no |
| resource\_share\_allow\_external\_principals | Whether or not to allow external principals for the Resource Share for the Transit Gateway. | string | `"true"` | no |
| resource\_share\_create | Whether or not to create a Resource Share for the Transit Gateway. This value cannot be computed automatically from other variables in Terraform 0.11.X. | string | `"false"` | no |
| resource\_share\_name | Name of the Resource Share for the Transit Gateway. | string | `""` | no |
| resource\_share\_tags | Tags of the Resource Share for the Transit Gateway. | map | `{}` | no |
| route\_attached\_vpc\_cidrs | All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the terrible Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc_routes_update=false. | list | `[ "127.0.0.1/32" ]` | no |
| route\_cidrs | All the CIDRs for the Transit Gateway route table. Note that the VPCs CIDR (for the current VPC and the attached VPCs) will be automatically propagated via VPC attachement and thus should not be in this list. | list | `[]` | no |
| tags | Tags of the Transit Gateway. | map | `{}` | no |
| transit\_gateway\_create | Whether or not to create the Transit Gateway. | string | `"true"` | no |
| vpc\_attachement\_create | Whether or not to create the Transit Gateway VPC attachment. | string | `"true"` | no |
| vpc\_id | Id of the VPC where to create the Transit Gateway. | string | `""` | no |
| vpc\_route\_ids | All the routes of the current VPC that should be aware of the sub accounts attached to the Transit Gateway. | list | `[]` | no |
| vpc\_routes\_update | Whether or not to update VPC routes. This value cannot be computed automatically from other variables in Terraform 0.11.X. | string | `"true"` | no |

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

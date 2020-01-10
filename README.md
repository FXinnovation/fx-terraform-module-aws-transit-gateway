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
| customer\_gateway\_name\_suffix | Suffix of the name of the Customer Gateways. | string | `"customer-gateway"` | no |
| customer\_gateway\_tags | Tags of the Customer Gateways. | map | `{}` | no |
| description | Description of the Transit Gateway. | string | `""` | no |
| enable | Whether or not to enable the entire module or not. | string | `"true"` | no |
| id | ID of an existing transit gateway for attachement. If not specify, the module will create a new Transit Gateway \(with var.tgw\_create = true\). | string | `""` | no |
| name\_suffix | Suffix of the name of the Transit Gateway. | string | `"transit-gateway"` | no |
| prefix | Prefix to be shared with all resource’s names of the module. | string | `"tgw"` | no |
| resource\_share\_account\_ids | Ids of the account where the Transit Gateway should be shared. | list | `[]` | no |
| resource\_share\_allow\_external\_principals | Whether or not to allow external principals for the Resource Share for the Transit Gateway. | string | `"true"` | no |
| resource\_share\_create | Whether or not to create a Resource Share for the Transit Gateway. This value cannot be computed automatically from other variables in Terraform 0.11.X. | string | `"false"` | no |
| resource\_share\_name | Name of the Resource Share for the Transit Gateway. | string | `""` | no |
| resource\_share\_name\_suffix | Suffix of the name of the Resource Share. | string | `"resource-share"` | no |
| resource\_share\_tags | Tags of the Resource Share for the Transit Gateway. | map | `{}` | no |
| route\_attached\_vpc\_cidrs | All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc\_routes\_update=false. | list | `[ "127.0.0.1/32" ]` | no |
| route\_attached\_vpn\_cidrs | All the CIDRs of the attached VPNs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc\_routes\_update=false. | list | `[ "127.0.0.1/32" ]` | no |
| subnet\_ids | Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to install the Transit Gateway. | list | `[]` | no |
| tags | Tags to be shared with all resources of the module. | map | `{}` | no |
| tgw\_create | Whether or not to create a Transit Gateway. This value cannot be computed automatically in Terraform 0.11. | string | `"true"` | no |
| tgw\_tags | Tags specific of the Transit Gateway. Will be merged with var.tags. | map | `{}` | no |
| vpc\_attachement\_create | Whether or not to create the Transit Gateway VPC attachment. | string | `"true"` | no |
| vpc\_attachement\_tags | Tags of the VPC attachement of the Transit Gateway. | map | `{}` | no |
| vpc\_attachment\_name\_suffix | Suffix of the name of the VPC attachements. | string | `"attachement"` | no |
| vpc\_id | Id of the VPC where to create the resources of the module. | string | `""` | no |
| vpc\_route\_table\_ids | All the route tables of the current VPC that should be aware of the sub accounts VPCs or VPNs attached to the Transit Gateway. They will be updated with  with route\_attached\_vpn\_cidrs and route\_attached\_vpc\_cidrs. | list | `[]` | no |
| vpc\_routes\_update | Whether or not to update VPC route tables with route\_attached\_vpn\_cidrs and route\_attached\_vpc\_cidrs. This value cannot be computed automatically from other variables in Terraform 0.11.X. | string | `"true"` | no |
| vpc\_transit\_gateway\_route\_cidr\_indexes | List of VPC Connection index that connects vpc\_transit\_gateway\_route\_cidrs with the correct VPN. Tied with vpc\_transit\_gateway\_route\_cidrs, must have the same number of element. | list | `[]` | no |
| vpc\_transit\_gateway\_route\_cidrs | List routes for the VPC attachement to bind to the Transit Gateway route table. Tied with vpc\_transit\_gateway\_route\_cidr\_indexes, must have the same number of element. | list | `[]` | no |
| vpn\_asns | List of : The gateway's Border Gateway Protocol \(BGP\) Autonomous System Number \(ASN\). | list | `[]` | no |
| vpn\_ips | List of VPN ip's for which you want a VPN Connection. | list | `[]` | no |
| vpn\_name\_suffix | Suffix of the name of the VPN Connections. | string | `"vpn"` | no |
| vpn\_static\_routes\_options | List of: Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP. | list | `[]` | no |
| vpn\_tags | Tags of the VPN Connections. | map | `{}` | no |
| vpn\_transit\_gateway\_route\_cidr\_indexes | List of VPN Connection index that connects vpn\_transit\_gateway\_route\_cidrs with the correct VPN. Tied with vpn\_transit\_gateway\_route\_cidrs, must have the same number of element. | list | `[]` | no |
| vpn\_transit\_gateway\_route\_cidrs | List routes for the VPN attachement to bind to the Transit Gateway route table. Tied with vpn\_transit\_gateway\_route\_cidr\_indexes, must have the same number of element. | list | `[]` | no |
| vpn\_type | List of : The types of the VPN connections. The only type AWS supports at this time is 'ipsec.1'. | string | `"ipsec.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| association\_default\_route\_table\_id |  |
| customer\_gateway\_ids |  |
| customer\_gateway\_ids\_count |  |
| customer\_gateway\_ips |  |
| customer\_gateway\_ips\_count |  |
| id |  |
| owner\_id |  |
| propagation\_default\_route\_table\_id |  |
| resource\_share\_id |  |
| vpc\_attachment\_id |  |
| vpn\_connection\_ids |  |
| vpn\_connection\_ids\_count |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

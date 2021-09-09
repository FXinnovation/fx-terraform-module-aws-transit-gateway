# terraform-module-aws-transit-gateway

Creates a Transit Gateway.

This module works for a simple Transit Gateway creation.
It also creat a VPC attachment, a shared resource for the Transit Gateway and update routes to point to the Transit Gateway.
For more features and use case, make a PR.

Note: the Transit Gateway share resource acceptance, the VPC attachment and route propagation for the **client account** is not implemented in this module.
For the following reasons:
- With AWS provider 1.59 automated Resource Share acceptance is not available.
- With terraform 0.11.X, VPC attachment in client accounts is not idempotent and will raise an error on subsequent calls.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/customer_gateway) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.this_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.this_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ram_principal_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route.this_vpc_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.this_vpn_routes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpn_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpn_connection) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs. | `number` | `64512` | no |
| <a name="input_customer_gateway_name_suffix"></a> [customer\_gateway\_name\_suffix](#input\_customer\_gateway\_name\_suffix) | Suffix of the name of the Customer Gateways. | `string` | `"customer-gateway"` | no |
| <a name="input_customer_gateway_tags"></a> [customer\_gateway\_tags](#input\_customer\_gateway\_tags) | Tags of the Customer Gateways. | `map` | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Transit Gateway. | `string` | `""` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Whether or not to enable the entire module or not. | `bool` | `true` | no |
| <a name="input_id"></a> [id](#input\_id) | ID of an existing transit gateway for attachement. If not specify, the module will create a new Transit Gateway (with var.tgw\_create = true). | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Suffix of the name of the Transit Gateway. | `string` | `"transit-gateway"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to be shared with all resource’s names of the module. | `string` | `"tgw"` | no |
| <a name="input_resource_share_account_ids"></a> [resource\_share\_account\_ids](#input\_resource\_share\_account\_ids) | Ids of the account where the Transit Gateway should be shared. | `list` | `[]` | no |
| <a name="input_resource_share_allow_external_principals"></a> [resource\_share\_allow\_external\_principals](#input\_resource\_share\_allow\_external\_principals) | Whether or not to allow external principals for the Resource Share for the Transit Gateway. | `bool` | `true` | no |
| <a name="input_resource_share_create"></a> [resource\_share\_create](#input\_resource\_share\_create) | Whether or not to create a Resource Share for the Transit Gateway. This value cannot be computed automatically from other variables in Terraform 0.11.X. | `bool` | `false` | no |
| <a name="input_resource_share_name"></a> [resource\_share\_name](#input\_resource\_share\_name) | Name of the Resource Share for the Transit Gateway. | `string` | `""` | no |
| <a name="input_resource_share_name_suffix"></a> [resource\_share\_name\_suffix](#input\_resource\_share\_name\_suffix) | Suffix of the name of the Resource Share. | `string` | `"resource-share"` | no |
| <a name="input_resource_share_tags"></a> [resource\_share\_tags](#input\_resource\_share\_tags) | Tags of the Resource Share for the Transit Gateway. | `map` | `{}` | no |
| <a name="input_route_attached_vpc_cidrs"></a> [route\_attached\_vpc\_cidrs](#input\_route\_attached\_vpc\_cidrs) | All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc\_routes\_update=false. | `list` | <pre>[<br>  "127.0.0.1/32"<br>]</pre> | no |
| <a name="input_route_attached_vpn_cidrs"></a> [route\_attached\_vpn\_cidrs](#input\_route\_attached\_vpn\_cidrs) | All the CIDRs of the attached VPNs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc\_routes\_update=false. | `list` | <pre>[<br>  "127.0.0.1/32"<br>]</pre> | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to install the Transit Gateway. | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be shared with all resources of the module. | `map` | `{}` | no |
| <a name="input_tgw_create"></a> [tgw\_create](#input\_tgw\_create) | Whether or not to create a Transit Gateway. This value cannot be computed automatically in Terraform 0.11. | `bool` | `true` | no |
| <a name="input_tgw_tags"></a> [tgw\_tags](#input\_tgw\_tags) | Tags specific of the Transit Gateway. Will be merged with var.tags. | `map` | `{}` | no |
| <a name="input_vpc_attachement_create"></a> [vpc\_attachement\_create](#input\_vpc\_attachement\_create) | Whether or not to create the Transit Gateway VPC attachment. | `bool` | `true` | no |
| <a name="input_vpc_attachement_tags"></a> [vpc\_attachement\_tags](#input\_vpc\_attachement\_tags) | Tags of the VPC attachement of the Transit Gateway. | `map` | `{}` | no |
| <a name="input_vpc_attachment_name_suffix"></a> [vpc\_attachment\_name\_suffix](#input\_vpc\_attachment\_name\_suffix) | Suffix of the name of the VPC attachements. | `string` | `"attachement"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id of the VPC where to create the resources of the module. | `string` | `""` | no |
| <a name="input_vpc_route_table_ids"></a> [vpc\_route\_table\_ids](#input\_vpc\_route\_table\_ids) | All the route tables of the current VPC that should be aware of the sub accounts VPCs or VPNs attached to the Transit Gateway. They will be updated with  with route\_attached\_vpn\_cidrs and route\_attached\_vpc\_cidrs. | `list` | `[]` | no |
| <a name="input_vpc_routes_update"></a> [vpc\_routes\_update](#input\_vpc\_routes\_update) | Whether or not to update VPC route tables with route\_attached\_vpn\_cidrs and route\_attached\_vpc\_cidrs. This value cannot be computed automatically from other variables in Terraform 0.11.X. | `bool` | `true` | no |
| <a name="input_vpc_transit_gateway_route_cidr_indexes"></a> [vpc\_transit\_gateway\_route\_cidr\_indexes](#input\_vpc\_transit\_gateway\_route\_cidr\_indexes) | List of VPC Connection index that connects vpc\_transit\_gateway\_route\_cidrs with the correct VPN. Tied with vpc\_transit\_gateway\_route\_cidrs, must have the same number of element. | `list` | `[]` | no |
| <a name="input_vpc_transit_gateway_route_cidrs"></a> [vpc\_transit\_gateway\_route\_cidrs](#input\_vpc\_transit\_gateway\_route\_cidrs) | List routes for the VPC attachement to bind to the Transit Gateway route table. Tied with vpc\_transit\_gateway\_route\_cidr\_indexes, must have the same number of element. | `list` | `[]` | no |
| <a name="input_vpn_asns"></a> [vpn\_asns](#input\_vpn\_asns) | List of : The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | `list` | `[]` | no |
| <a name="input_vpn_ips"></a> [vpn\_ips](#input\_vpn\_ips) | List of VPN ip's for which you want a VPN Connection. | `list` | `[]` | no |
| <a name="input_vpn_name_suffix"></a> [vpn\_name\_suffix](#input\_vpn\_name\_suffix) | Suffix of the name of the VPN Connections. | `string` | `"vpn"` | no |
| <a name="input_vpn_static_routes_options"></a> [vpn\_static\_routes\_options](#input\_vpn\_static\_routes\_options) | List of: Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP. | `list` | `[]` | no |
| <a name="input_vpn_tags"></a> [vpn\_tags](#input\_vpn\_tags) | Tags of the VPN Connections. | `map` | `{}` | no |
| <a name="input_vpn_transit_gateway_route_cidr_indexes"></a> [vpn\_transit\_gateway\_route\_cidr\_indexes](#input\_vpn\_transit\_gateway\_route\_cidr\_indexes) | List of VPN Connection index that connects vpn\_transit\_gateway\_route\_cidrs with the correct VPN. Tied with vpn\_transit\_gateway\_route\_cidrs, must have the same number of element. | `list` | `[]` | no |
| <a name="input_vpn_transit_gateway_route_cidrs"></a> [vpn\_transit\_gateway\_route\_cidrs](#input\_vpn\_transit\_gateway\_route\_cidrs) | List routes for the VPN attachement to bind to the Transit Gateway route table. Tied with vpn\_transit\_gateway\_route\_cidr\_indexes, must have the same number of element. | `list` | `[]` | no |
| <a name="input_vpn_type"></a> [vpn\_type](#input\_vpn\_type) | List of : The types of the VPN connections. The only type AWS supports at this time is 'ipsec.1'. | `string` | `"ipsec.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_association_default_route_table_id"></a> [association\_default\_route\_table\_id](#output\_association\_default\_route\_table\_id) | n/a |
| <a name="output_customer_gateway_ids"></a> [customer\_gateway\_ids](#output\_customer\_gateway\_ids) | n/a |
| <a name="output_customer_gateway_ids_count"></a> [customer\_gateway\_ids\_count](#output\_customer\_gateway\_ids\_count) | n/a |
| <a name="output_customer_gateway_ips"></a> [customer\_gateway\_ips](#output\_customer\_gateway\_ips) | n/a |
| <a name="output_customer_gateway_ips_count"></a> [customer\_gateway\_ips\_count](#output\_customer\_gateway\_ips\_count) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | n/a |
| <a name="output_propagation_default_route_table_id"></a> [propagation\_default\_route\_table\_id](#output\_propagation\_default\_route\_table\_id) | n/a |
| <a name="output_resource_share_id"></a> [resource\_share\_id](#output\_resource\_share\_id) | n/a |
| <a name="output_vpc_attachment_id"></a> [vpc\_attachment\_id](#output\_vpc\_attachment\_id) | n/a |
| <a name="output_vpn_connection_ids"></a> [vpn\_connection\_ids](#output\_vpn\_connection\_ids) | n/a |
| <a name="output_vpn_connection_ids_count"></a> [vpn\_connection\_ids\_count](#output\_vpn\_connection\_ids\_count) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

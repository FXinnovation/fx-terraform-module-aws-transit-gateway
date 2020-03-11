#####
# General
#####

variable "enable" {
  description = "Whether or not to enable the entire module or not."
  default     = true
}

variable "prefix" {
  description = "Prefix to be shared with all resource’s names of the module."
  default     = "tgw"
}

variable "tags" {
  description = "Tags to be shared with all resources of the module."
  default     = {}
}

variable "vpc_id" {
  description = "Id of the VPC where to create the resources of the module."
  default     = ""
}

#####
# Transit Gateway
#####

variable "id" {
  description = "ID of an existing transit gateway for attachement. If not specify, the module will create a new Transit Gateway (with var.tgw_create = true)."
  default     = ""
}

variable "description" {
  description = "Description of the Transit Gateway."
  default     = ""
}

variable "name_suffix" {
  description = "Suffix of the name of the Transit Gateway."
  default     = "transit-gateway"
}

variable "subnet_ids" {
  description = "Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to install the Transit Gateway."
  default     = []
}

variable "amazon_side_asn" {
  description = "Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for 32-bit ASNs."
  default     = 64512
}

variable "tgw_create" {
  description = "Whether or not to create a Transit Gateway. This value cannot be computed automatically in Terraform 0.11."
  default     = true
}

variable "tgw_tags" {
  description = "Tags specific of the Transit Gateway. Will be merged with var.tags."
  default     = {}
}

#####
# Routes
#####

variable "vpc_route_table_ids" {
  description = "All the route tables of the current VPC that should be aware of the sub accounts VPCs or VPNs attached to the Transit Gateway. They will be updated with  with route_attached_vpn_cidrs and route_attached_vpc_cidrs."
  default     = []
}

variable "vpc_routes_update" {
  description = "Whether or not to update VPC route tables with route_attached_vpn_cidrs and route_attached_vpc_cidrs. This value cannot be computed automatically from other variables in Terraform 0.11.X."
  default     = true
}

variable "route_attached_vpc_cidrs" {
  description = "All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc_routes_update=false."
  default     = ["127.0.0.1/32"]
}

variable "route_attached_vpn_cidrs" {
  description = "All the CIDRs of the attached VPNs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc_routes_update=false."
  default     = ["127.0.0.1/32"]
}

#####
# VPC Attachement
#####

variable "vpc_attachement_create" {
  description = "Whether or not to create the Transit Gateway VPC attachment."
  default     = true
}

variable "vpc_attachment_name_suffix" {
  description = "Suffix of the name of the VPC attachements."
  default     = "attachement"
}

variable "vpc_attachement_tags" {
  description = "Tags of the VPC attachement of the Transit Gateway."
  default     = {}
}

variable "vpc_transit_gateway_route_cidr_indexes" {
  description = "List of VPC Connection index that connects vpc_transit_gateway_route_cidrs with the correct VPN. Tied with vpc_transit_gateway_route_cidrs, must have the same number of element."
  default     = []
}

variable "vpc_transit_gateway_route_cidrs" {
  description = "List routes for the VPC attachement to bind to the Transit Gateway route table. Tied with vpc_transit_gateway_route_cidr_indexes, must have the same number of element."
  default     = []
}

#####
# VPN Attachement
#####

variable "customer_gateway_name_suffix" {
  description = "Suffix of the name of the Customer Gateways."
  default     = "customer-gateway"
}

variable "customer_gateway_tags" {
  description = "Tags of the Customer Gateways."
  default     = {}
}

variable "vpn_asns" {
  description = "List of : The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  default     = []
}

variable "vpn_ips" {
  description = "List of VPN ip's for which you want a VPN Connection."
  default     = []
}

variable "vpn_name_suffix" {
  description = "Suffix of the name of the VPN Connections."
  default     = "vpn"
}

variable "vpn_static_routes_options" {
  description = "List of: Whether the VPN connection uses static routes exclusively. Static routes must be used for devices that don't support BGP."
  default     = []
}

variable "vpn_tags" {
  description = "Tags of the VPN Connections."
  default     = {}
}

variable "vpn_type" {
  description = "List of : The types of the VPN connections. The only type AWS supports at this time is 'ipsec.1'."
  default     = "ipsec.1"
}

variable "vpn_transit_gateway_route_cidr_indexes" {
  description = "List of VPN Connection index that connects vpn_transit_gateway_route_cidrs with the correct VPN. Tied with vpn_transit_gateway_route_cidrs, must have the same number of element."
  default     = []
}

variable "vpn_transit_gateway_route_cidrs" {
  description = "List routes for the VPN attachement to bind to the Transit Gateway route table. Tied with vpn_transit_gateway_route_cidr_indexes, must have the same number of element."
  default     = []
}

#####
# Resource Share
#####

variable "resource_share_allow_external_principals" {
  description = "Whether or not to allow external principals for the Resource Share for the Transit Gateway."
  default     = true
}

variable "resource_share_account_ids" {
  description = "Ids of the account where the Transit Gateway should be shared."
  default     = []
}

variable "resource_share_create" {
  description = "Whether or not to create a Resource Share for the Transit Gateway. This value cannot be computed automatically from other variables in Terraform 0.11.X."
  default     = false
}

variable "resource_share_name" {
  description = "Name of the Resource Share for the Transit Gateway."
  default     = ""
}

variable "resource_share_name_suffix" {
  description = "Suffix of the name of the Resource Share."
  default     = "resource-share"
}

variable "resource_share_tags" {
  description = "Tags of the Resource Share for the Transit Gateway."
  default     = {}
}

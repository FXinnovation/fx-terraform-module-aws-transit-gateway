variable "name" {
  description = "Name prefix to be shared with all resources."
  default     = "tgw"
}

variable "tags" {
  description = "Tags to be shared with all resources."

  default = {
    Terraform = true
  }
}

#####
# Transit Gateway
#####

variable "transit_gateway_create" {
  description = "Whether or not to create the Transit Gateway."
  default     = true
}

variable "transit_gateway_description" {
  description = "Description of the Transit Gateway."
  default     = ""
}

variable "transit_gateway_name_suffix" {
  description = "Suffix of the name of the Transit Gateway."
  default     = "transit-gateway"
}

variable "transit_gateway_subnet_ids" {
  description = "Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to install the Transit Gateway."
  default     = []
}

variable "transit_gateway_tags" {
  description = "Tags of the Transit Gateway."
  default     = {}
}

variable "vpc_id" {
  description = "Id of the VPC where to create the Transit Gateway."
  default     = ""
}

variable "transit_gateway_route_cidrs_count" {
  description = "How many transit_gateway_route_cidrs to add to the Transit Gateway route table. This value cannot be computed automatically from transit_gateway_route_cidrs in Terraform 0.11.X"
  default     = 0
}

variable "transit_gateway_route_cidrs" {
  description = "All the CIDRs for the Transit Gateway route table. Note that the VPCs CIDR (for the current VPC and the attached VPCs) will be automatically propagated via VPC attachement and thus should not be in this list."
  default     = []
}

#####
# Routes
#####

variable "vpc_route_table_count" {
  description = "The count of all the route tables of the current VPC that should be aware of the sub accounts/VPN attached to the Transit Gateway. This value cannot be computed automatically from vpc_route_table_ids in Terraform 0.11.X."
  default     = 0
}

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

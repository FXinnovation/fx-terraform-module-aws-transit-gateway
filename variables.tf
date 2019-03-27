variable "name" {
  description = "Name of the Transit Gateway."
  default     = ""
}

variable "description" {
  description = "Description of the Transit Gateway."
  default     = ""
}

variable "attachement_subnet_ids" {
  description = "Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to put the Transit Gateway."
  default     = []
}

variable "transit_gateway_create" {
  description = "Whether or not to create the Transit Gateway."
  default     = true
}

variable "vpc_attachement_create" {
  description = "Whether or not to create the Transit Gateway VPC attachment."
  default     = true
}

variable "vpc_id" {
  description = "Id of the VPC where to create the Transit Gateway."
  default     = ""
}

variable "vpc_route_table_ids" {
  description = "All the route tables of the current VPC that should be aware of the sub accounts/VPN attached to the Transit Gateway."
  default     = []
}

variable "vpc_routes_update" {
  description = "Whether or not to update VPC routes. This value cannot be computed automatically from other variables in Terraform 0.11.X."
  default     = true
}

variable "tags" {
  description = "Tags of the Transit Gateway."
  default     = {}
}

variable "attachement_tags" {
  description = "Tags of the VPC attachement of the Transit Gateway."
  default     = {}
}

variable "route_cidrs" {
  description = "All the CIDRs for the Transit Gateway route table. Note that the VPCs CIDR (for the current VPC and the attached VPCs) will be automatically propagated via VPC attachement and thus should not be in this list."
  default     = []
}

#####
# Resource Share
#####

variable "resource_share_allow_external_principals" {
  description = "Whether or not to allow external principals for the Resource Share for the Transit Gateway."
  default     = true
}

variable "route_attached_vpc_cidrs" {
  description = "All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc_routes_update=false."
  default     = ["127.0.0.1/32"]
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

variable "resource_share_tags" {
  description = "Tags of the Resource Share for the Transit Gateway."
  default     = {}
}

#####
# VPN
#####

variable "vpn_ips" {
  description = "List of VPN ip's for which you want a VPN Connection."
  default     = []
}

variable "vpn_types" {
  description = "List of : The types of the VPN connections. The only type AWS supports at this time is 'ipsec.1'."
  default     = []
}

variable "vpn_asns" {
  description = "List of : The gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN)."
  default     = []
}

variable "vpn_tags" {
  description = "Tags of the VPN Connections."
  default     = {}
}

variable "customer_gateway_tags" {
  description = "Tags of the Customer Gateways."
  default     = {}
}

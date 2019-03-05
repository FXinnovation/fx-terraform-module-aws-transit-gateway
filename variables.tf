variable "name" {
  description = "Name of the Transit Gateway."
}

variable "description" {
  description = "Description of the Transit Gateway."
}

variable "attachement_subnet_ids" {
  description = "Subnets to attached to the Transit Gateway. These subnets will be used internally by AWS to put the Transit Gateway."
  default     = []
}

variable "vpc_id" {
  description = "Id of the VPC where to create the Transit Gateway."
}

variable "vpc_route_ids" {
  description = "All the routes of the current VPC that should be aware of the sub accounts attached to the Transit Gateway."
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
  description = "All the CIDRs of the attached VPCs to the Transit Gateway. These routes will be used to update the current VPC route tables, not the Transit Gateway route table itself. Note: the default value solves the terrible Terraform variable preprocessing in 0.11.X, preventing conditions to work correctly when this variable is an empty list. To make sure routes are not updated with this dummy value, set vpc_routes_update=false."
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

#####
# Transit Gateway
#####

resource "aws_ec2_transit_gateway" "this" {
  count = var.enable && var.tgw_create ? 1 : 0

  description                     = var.description
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = merge(
    {
      "Name" = format("%s-%s-%02d", var.prefix, var.name_suffix, count.index + 1)
    },
    {
      "Terraform" = true
    },
    var.tags,
    var.tgw_tags,
  )
}

#####
# VPC Attachements
#####

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.enable && var.vpc_attachement_create ? 1 : 0

  subnet_ids         = var.subnet_ids
  transit_gateway_id = element(concat(data.aws_ec2_transit_gateway.this.*.id, [""]), 0)
  vpc_id             = var.vpc_id

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = merge(
    {
      "Name" = format(
        "%s-%s-%02d",
        var.prefix,
        var.vpc_attachment_name_suffix,
        count.index + 1,
      )
    },
    {
      "Terraform" = true
    },
    var.tags,
    var.vpc_attachement_tags,
  )
}

resource "aws_ec2_transit_gateway_route" "this_vpc" {
  count = var.enable ? length(var.vpc_transit_gateway_route_cidrs) : 0

  destination_cidr_block = element(var.vpc_transit_gateway_route_cidrs, count.index)
  transit_gateway_attachment_id = element(
    aws_ec2_transit_gateway_vpc_attachment.this.*.id,
    element(var.vpc_transit_gateway_route_cidr_indexes, count.index),
  )
  transit_gateway_route_table_id = element(
    concat(
      data.aws_ec2_transit_gateway.this.*.association_default_route_table_id,
      [""],
    ),
    0,
  )
}

#####
# VPN Attachements
#####

resource "aws_customer_gateway" "this" {
  count = var.enable ? length(var.vpn_ips) : 0

  bgp_asn    = element(var.vpn_asns, count.index)
  ip_address = element(var.vpn_ips, count.index)
  type       = var.vpn_type

  tags = merge(
    {
      "Name" = format(
        "%s-%s-%02d",
        var.prefix,
        var.customer_gateway_name_suffix,
        count.index + 1,
      )
    },
    {
      "Terraform" = true
    },
    var.tags,
    var.customer_gateway_tags,
  )
}

resource "aws_vpn_connection" "this" {
  count = var.enable ? length(var.vpn_ips) : 0

  transit_gateway_id  = element(concat(data.aws_ec2_transit_gateway.this.*.id, [""]), 0)
  customer_gateway_id = element(aws_customer_gateway.this.*.id, count.index)
  static_routes_only  = element(var.vpn_static_routes_options, count.index)
  type                = var.vpn_type

  tags = merge(
    {
      "Name" = format(
        "%s-%s-%02d",
        var.prefix,
        var.vpn_name_suffix,
        count.index + 1,
      )
    },
    {
      "Terraform" = true
    },
    var.tags,
    var.vpn_tags,
  )
}

resource "aws_ec2_transit_gateway_route" "this_vpn" {
  count = var.enable ? length(var.vpn_transit_gateway_route_cidrs) : 0

  destination_cidr_block = element(var.vpn_transit_gateway_route_cidrs, count.index)
  transit_gateway_attachment_id = element(
    concat(
      aws_vpn_connection.this.*.transit_gateway_attachment_id,
      [""],
    ),
    element(var.vpn_transit_gateway_route_cidr_indexes, count.index),
  )
  transit_gateway_route_table_id = element(
    concat(
      data.aws_ec2_transit_gateway.this.*.association_default_route_table_id,
      [""],
    ),
    0,
  )

  depends_on = [aws_ec2_transit_gateway.this]
}

#####
# Resource Share
#####

resource "aws_ram_resource_share" "this" {
  count = var.enable && var.resource_share_create ? 1 : 0

  name                      = var.resource_share_name
  allow_external_principals = var.resource_share_allow_external_principals

  tags = merge(
    {
      "Name" = format(
        "%s-%s-%02d",
        var.prefix,
        var.resource_share_name_suffix,
        count.index + 1,
      )
    },
    {
      "Terraform" = true
    },
    var.tags,
    var.resource_share_tags,
  )
}

resource "aws_ram_principal_association" "this" {
  count = var.enable && var.resource_share_create ? length(var.resource_share_account_ids) : 0

  principal          = element(var.resource_share_account_ids, count.index)
  resource_share_arn = aws_ram_resource_share.this[0].id
}

resource "aws_ram_resource_association" "this" {
  count = var.enable && var.resource_share_create ? 1 : 0

  resource_arn       = element(concat(data.aws_ec2_transit_gateway.this.*.arn, [""]), 0)
  resource_share_arn = aws_ram_resource_share.this[0].id
}

#####
# Routes
#####

resource "aws_route" "this_vpc_routes" {
  count = var.enable && var.vpc_routes_update ? length(var.vpc_route_table_ids) * length(var.route_attached_vpc_cidrs) : 0

  route_table_id = element(
    var.vpc_route_table_ids,
    floor(count.index / length(var.route_attached_vpc_cidrs)),
  )
  destination_cidr_block = element(
    var.route_attached_vpc_cidrs,
    count.index % length(var.route_attached_vpc_cidrs),
  )
  transit_gateway_id = element(concat(data.aws_ec2_transit_gateway.this.*.id, [""]), 0)

  depends_on = [
    aws_ec2_transit_gateway.this,
    aws_ec2_transit_gateway_vpc_attachment.this,
  ]
}

resource "aws_route" "this_vpn_routes" {
  count = var.enable && var.vpc_routes_update ? length(var.vpc_route_table_ids) * length(var.route_attached_vpn_cidrs) : 0

  route_table_id = element(
    var.vpc_route_table_ids,
    floor(count.index / length(var.route_attached_vpn_cidrs)),
  )
  destination_cidr_block = element(
    var.route_attached_vpn_cidrs,
    count.index % length(var.route_attached_vpn_cidrs),
  )
  transit_gateway_id = element(concat(data.aws_ec2_transit_gateway.this.*.id, [""]), 0)

  depends_on = [
    aws_ec2_transit_gateway.this,
    aws_vpn_connection.this,
  ]
}

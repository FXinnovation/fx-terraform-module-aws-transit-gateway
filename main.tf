terraform {
  required_providers = {
    aws = ">= 2.4.0"
  }
}

#####
# Transit Gateway
#####

resource "aws_ec2_transit_gateway" "this" {
  count = "${var.transit_gateway_create}"

  description                     = "${var.transit_gateway_description}"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = "${merge(map("Name", format("%s-%s-%02d", var.name, var.transit_gateway_name_suffix, count.index + 1)), var.tags, var.transit_gateway_tags)}"
}

resource "aws_ec2_transit_gateway_route" "this" {
  count = "${var.transit_gateway_route_cidrs_count}"

  destination_cidr_block         = "${element(var.transit_gateway_route_cidrs, count.index)}"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.this.id}"
  transit_gateway_route_table_id = "${element(concat(aws_ec2_transit_gateway.this.*.association_default_route_table_id, list("")), 0)}"
}

#####
# VPC Attachements
#####

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = "${var.vpc_attachement_create}"

  subnet_ids         = ["${var.transit_gateway_subnet_ids}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.this.id}"
  vpc_id             = "${var.vpc_id}"

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = "${merge(map("Name", format("%s-%s-%02d", var.name, var.vpc_attachment_name_suffix, count.index + 1)), var.tags, var.vpc_attachement_tags)}"
}

#####
# VPN Attachements
#####

resource "aws_customer_gateway" "this" {
  count = "${length(var.vpn_ips)}"

  bgp_asn    = "${element(var.vpn_asns, count.index)}"
  ip_address = "${element(var.vpn_ips, count.index)}"
  type       = "${var.vpn_type}"

  tags = "${merge(map("Name", format("%s-%s-%02d", var.name, var.customer_gateway_name_suffix, count.index + 1)), var.tags, var.customer_gateway_tags)}"
}

resource "aws_vpn_connection" "this" {
  count = "${length(var.vpn_ips)}"

  transit_gateway_id  = "${aws_ec2_transit_gateway.this.id}"
  customer_gateway_id = "${element(aws_customer_gateway.this.*.id, count.index)}"
  static_routes_only  = "${element(var.vpn_static_routes_options, count.index)}"
  type                = "${var.vpn_type}"

  tags = "${merge(map("Name", format("%s-%s-%02d", var.name, var.vpn_name_suffix, count.index + 1)), var.tags, var.vpn_tags)}"
}

resource "aws_ec2_transit_gateway_vpn_attachment" "this" {
  count = "${length(var.vpn_ips)}"

  transit_gateway_id = "${aws_ec2_transit_gateway.this.id}"
  vpn_connection_id  = "${element(aws_vpn_connection.example.*.id, count.index)}"

  tags = "${merge(map("Name", format("%s-%s-%02d", var.name, var.vpn_attachment_name_suffix, count.index + 1)), var.tags, var.vpn_attachement_tags)}"
}

#####
# Resource Share
#####

resource "aws_ram_resource_share" "this" {
  count = "${var.resource_share_create}"

  name                      = "${var.resource_share_name}"
  allow_external_principals = "${var.resource_share_allow_external_principals}"

  tags = "${merge(map("Name", format("%s-%s-%02d", var.name, var.resource_share_name_suffix, count.index + 1)), var.tags, var.resource_share_tags)}"
}

resource "aws_ram_principal_association" "this" {
  count = "${var.resource_share_create}"

  principal          = "${element(var.resource_share_account_ids, count.index)}"
  resource_share_arn = "${aws_ram_resource_share.this.id}"
}

resource "aws_ram_resource_association" "this" {
  count = "${var.resource_share_create}"

  resource_arn       = "${aws_ec2_transit_gateway.this.arn}"
  resource_share_arn = "${aws_ram_resource_share.this.id}"
}

#####
# Routes
#####

resource "aws_route" "this_vpc_routes" {
  count = "${var.vpc_routes_update ? var.vpc_route_table_count * length(var.route_attached_vpc_cidrs) : 0}"

  route_table_id         = "${element(var.vpc_route_table_ids, count.index / length(var.route_attached_vpc_cidrs))}"
  destination_cidr_block = "${element(var.route_attached_vpc_cidrs, count.index % length(var.route_attached_vpc_cidrs))}"
  transit_gateway_id     = "${aws_ec2_transit_gateway.this.id}"
}

resource "aws_route" "this_vpn_routes" {
  count = "${var.vpc_routes_update ? var.vpc_route_table_count * length(var.route_attached_vpn_cidrs) : 0}"

  route_table_id         = "${element(var.vpc_route_table_ids, count.index / length(var.route_attached_vpn_cidrs))}"
  destination_cidr_block = "${element(var.route_attached_vpn_cidrs, count.index % length(var.route_attached_vpn_cidrs))}"
  transit_gateway_id     = "${aws_ec2_transit_gateway.this.id}"
}

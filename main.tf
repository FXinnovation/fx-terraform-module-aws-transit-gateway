#####
# Transit Gateway
#####

resource "aws_ec2_transit_gateway" "this" {
  count = "${var.transit_gateway_create}"

  description                     = "${var.description}"
  auto_accept_shared_attachments  = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = "${merge(map("Name", format("%s", var.name)), map("Terraform", "true"), var.tags)}"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = "${var.vpc_attachement_create}"

  subnet_ids         = ["${var.attachement_subnet_ids}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.this.id}"
  vpc_id             = "${var.vpc_id}"

  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true

  tags = "${merge(map("Name", format("%s", var.name)), map("Terraform", "true"), var.attachement_tags)}"
}

resource "aws_ec2_transit_gateway_route" "this" {
  count = "${length(var.route_cidrs)}"

  destination_cidr_block         = "${element(var.route_cidrs, count.index)}"
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.this.id}"
  transit_gateway_route_table_id = "${element(concat(aws_ec2_transit_gateway.this.*.association_default_route_table_id, list("")), 0)}"
}

#####
# VPN
#####

resource "aws_customer_gateway" "this" {
  count = "${length(var.vpn_ips)}"

  bgp_asn    = "${element(var.vpn_asns, count.index)}"
  ip_address = "${element(var.vpn_ips, count.index)}"
  type       = "${element(var.vpn_types, count.index)}"

  tags = "${merge(map("Name", format("%s-%02d", var.name, count.index)), map("Terraform", "true"), var.customer_gateway_tags)}"
}

resource "aws_vpn_connection" "this" {
  count = "${length(var.vpn_ips)}"

  transit_gateway_id  = "${aws_ec2_transit_gateway.this.id}"
  customer_gateway_id = "${element(aws_customer_gateway.this.*.id, count.index)}"
  type                = "${element(var.vpn_types, count.index)}"
  static_routes_only  = "${element(var.vpn_static_routes_options, count.index)}"

  tags = "${merge(map("Name", format("%s-%02d", var.name, count.index)), map("Terraform", "true"), var.vpn_tags)}"
}

resource "aws_route" "this_vpn_routes" {
  count = "${var.vpc_routes_update ? length(var.vpc_route_table_ids) * length(var.route_attached_vpn_cidrs) : 0}"

  route_table_id         = "${element(var.vpc_route_table_ids, count.index / length(var.route_attached_vpn_cidrs))}"
  destination_cidr_block = "${element(var.route_attached_vpn_cidrs, count.index % length(var.route_attached_vpn_cidrs))}"
  transit_gateway_id     = "${aws_ec2_transit_gateway.this.id}"
}

#####
# Resource Share
#####

resource "aws_ram_resource_share" "this" {
  count = "${var.resource_share_create}"

  name                      = "${var.resource_share_name}"
  allow_external_principals = "${var.resource_share_allow_external_principals}"

  tags = "${merge(map("Name", format("%s", var.name)), map("Terraform", "true"), var.resource_share_tags)}"
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

resource "aws_route" "this" {
  count = "${var.vpc_routes_update ? length(var.vpc_route_table_ids) * length(var.route_attached_vpc_cidrs) : 0}"

  route_table_id         = "${element(var.vpc_route_table_ids, count.index / length(var.route_attached_vpc_cidrs))}"
  destination_cidr_block = "${element(var.route_attached_vpc_cidrs, count.index % length(var.route_attached_vpc_cidrs))}"
  transit_gateway_id     = "${aws_ec2_transit_gateway.this.id}"
}

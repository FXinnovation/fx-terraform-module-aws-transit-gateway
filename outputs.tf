output "arn" {
  value = "${element(concat(aws_ec2_transit_gateway.this.*.arn, list("")), 0)}"
}

output "association_default_route_table_id" {
  value = "${element(concat(aws_ec2_transit_gateway.this.*.association_default_route_table_id, list("")), 0)}"
}

output "id" {
  value = "${element(concat(aws_ec2_transit_gateway.this.*.id, list("")), 0)}"
}

output "owner_id" {
  value = "${element(concat(aws_ec2_transit_gateway.this.*.owner_id, list("")), 0)}"
}

output "propagation_default_route_table_id" {
  value = "${element(concat(aws_ec2_transit_gateway.this.*.propagation_default_route_table_id, list("")), 0)}"
}

output "vpc_attachment_id" {
  value = "${element(concat(aws_ec2_transit_gateway_vpc_attachment.this.*.id, list("")), 0)}"
}

output "resource_share_id" {
  value = "${element(concat(aws_ram_resource_share.this.*.id, list("")), 0)}"
}

output "vpn_connection_ids" {
  value = "${element(concat(aws_vpn_connection.this.*.id, list("")), 0)}"
}

output "vpn_connection_ids_length" {
  value = "${length(aws_vpn_connection.this.*.id)}"
}

output "customer_gateway_ids" {
  value = "${element(concat(aws_customer_gateway.this.*.id, list("")), 0)}"
}

output "customer_gateway_ids_length" {
  value = "${length(aws_customer_gateway.this.*.id)}"
}

output "customer_gateway_ips" {
  value = "${element(concat(aws_customer_gateway.this.*.ip_address, list("")), 0)}"
}

output "customer_gateway_ips_length" {
  value = "${length(aws_customer_gateway.this.*.ip_address)}"
}

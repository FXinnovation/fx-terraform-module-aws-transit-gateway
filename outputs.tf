output "arn" {
  value = "${element(concat(aws_ec2_transit_gateway.transit_gateway.*.arn, list("")), 0)}"
}

output "association_default_route_table_id" {
  value = "${element(concat(aws_ec2_transit_gateway.transit_gateway.*.association_default_route_table_id, list("")), 0)}"
}

output "id" {
  value = "${element(concat(aws_ec2_transit_gateway.transit_gateway.*.id, list("")), 0)}"
}

output "owner_id" {
  value = "${element(concat(aws_ec2_transit_gateway.transit_gateway.*.owner_id, list("")), 0)}"
}

output "propagation_default_route_table_id" {
  value = "${element(concat(aws_ec2_transit_gateway.transit_gateway.*.propagation_default_route_table_id, list("")), 0)}"
}

output "vpc_attachment_id" {
  value = "${element(concat(aws_ec2_transit_gateway_vpc_attachment.transit_gateway.*.id, list("")), 0)}"
}

output "resource_share_id" {
  value = "${element(concat(aws_ram_resource_share.transit_gateway.*.id, list("")), 0)}"
}

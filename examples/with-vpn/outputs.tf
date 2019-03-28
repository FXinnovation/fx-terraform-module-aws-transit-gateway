output "arn" {
  value = "${module.with-vpn.arn}"
}

output "association_default_route_table_id" {
  value = "${module.with-vpn.association_default_route_table_id}"
}

output "id" {
  value = "${module.with-vpn.id}"
}

output "owner_id" {
  value = "${module.with-vpn.owner_id}"
}

output "propagation_default_route_table_id" {
  value = "${module.with-vpn.propagation_default_route_table_id}"
}

output "vpc_attachment_id" {
  value = "${module.with-vpn.vpc_attachment_id}"
}

output "resource_share_id" {
  value = "${module.with-vpn.resource_share_id}"
}

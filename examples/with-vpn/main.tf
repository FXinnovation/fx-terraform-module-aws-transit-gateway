provider "aws" {
  version    = "~> 2.4.0"
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_route_table" "selected" {
  vpc_id = "${data.aws_vpc.default.id}"
}

module "with-vpn" {
  source = "../../"

  name                              = "tftest"
  transit_gateway_description       = "Terraform test Transit Gateway"
  transit_gateway_subnet_ids        = "${data.aws_subnet_ids.all.ids}"
  transit_gateway_route_cidrs_count = 1
  transit_gateway_route_cidrs       = ["10.90.10.0/24"]
  vpc_id                            = "${data.aws_vpc.default.id}"
  vpc_route_table_ids               = ["${data.aws_route_table.selected.id}"]
  vpc_routes_update                 = false
  vpn_ips                           = ["172.0.0.1", "173.0.0.1"]
  vpn_asns                          = [65000, 65000]
  vpn_static_routes_options         = [false, true]

  vpn_tags = {
    foo = "bar"
  }

  tags = {
    Terraform = "test"
  }

  resource_share_create = false
}

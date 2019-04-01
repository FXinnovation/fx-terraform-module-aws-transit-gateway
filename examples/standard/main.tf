provider "aws" {
  version    = "~> 2.2.0"
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

module "standard" {
  source = "../../"

  name                              = "tftest"
  transit_gateway_description       = "Terraform test Transit Gateway"
  transit_gateway_subnet_ids        = "${data.aws_subnet_ids.all.ids}"
  transit_gateway_route_cidrs_count = 1
  transit_gateway_route_cidrs       = ["10.90.10.0/24"]
  vpc_id                            = "${data.aws_vpc.default.id}"
  vpc_route_table_ids               = ["${data.aws_route_table.selected.id}"]
  vpc_routes_update                 = false

  tags = {
    Terraform = "test"
  }

  vpc_attachement_tags = {
    foo = "bar"
  }

  resource_share_create = false
}

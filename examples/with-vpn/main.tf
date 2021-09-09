data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_route_table" "selected" {
  vpc_id = data.aws_vpc.default.id
}

module "with-vpn" {
  source = "../../"

  prefix                    = "tftest"
  description               = "Terraform test Transit Gateway"
  subnet_ids                = data.aws_subnet_ids.all.ids
  vpc_id                    = data.aws_vpc.default.id
  vpc_route_table_ids       = [data.aws_route_table.selected.id]
  vpc_routes_update         = false
  vpn_ips                   = ["172.0.0.1", "173.0.0.1"]
  vpn_asns                  = [65000, 65000]
  vpn_static_routes_options = [false, true]

  vpc_transit_gateway_route_cidrs        = [data.aws_vpc.default.cidr_block]
  vpc_transit_gateway_route_cidr_indexes = [0]

  vpn_transit_gateway_route_cidrs        = ["20.5.0.0/16", "20.10.0.0/16", "20.11.0.0/16"]
  vpn_transit_gateway_route_cidr_indexes = [0, 1, 1]

  vpn_tags = {
    foo = "bar"
  }

  tags = {
    Terraform = "test"
  }

  resource_share_create = false
}

provider "aws" {
  version    = "~> 2.2.0"
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "no_gateway" {
  source = "../../"

  transit_gateway_create      = false
  vpc_attachement_create      = false
  resource_share_create       = false
  transit_gateway_route_cidrs = []
  vpc_routes_update           = false
}

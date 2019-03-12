provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "standard" {
  source = "../../"

  transit_gateway_create = false
  vpc_attachement_create = false
  resource_share_create  = false
  route_cidrs            = []
  vpc_routes_update      = false
}

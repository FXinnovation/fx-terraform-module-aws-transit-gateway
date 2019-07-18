provider "aws" {
  version    = "~> 2.18.0"
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

  assume_role {
    role_arn     = "arn:aws:iam::700633540182:role/OrganizationAccountAccessRole"
    session_name = "TfTest"
  }
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

resource "random_integer" "this" {
  min = 1
  max = 254
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_vpc" "main" {
  cidr_block = "${format("10.%s.0.0/16", random_integer.this.result)}"
}

resource "aws_subnet" "main_sub1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${format("10.%s.0.0/20", random_integer.this.result)}"
}

resource "aws_subnet" "main_sub2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${format("10.%s.16.0/20", random_integer.this.result)}"
}

data "aws_route_table" "selected" {
  vpc_id = "${data.aws_vpc.default.id}"
}

module "standard" {
  source = "../../"

  prefix              = "tftest${random_string.this.result}TGW"
  description         = "Terraform test Transit Gateway"
  subnet_ids          = "${data.aws_subnet_ids.all.ids}"
  vpc_id              = "${data.aws_vpc.default.id}"
  vpc_route_table_ids = ["${data.aws_route_table.selected.id}"]
  vpc_routes_update   = false

  tags = {
    Terraform = "tftest${random_string.this.result}TGW"
  }

  resource_share_create = false
}

module "other_vpc_attachement" {
  source = "../../"

  id         = "${module.standard.id}"
  vpc_id     = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.main_sub1.id}", "${aws_subnet.main_sub2.id}"]

  tgw_create             = false
  vpc_attachement_create = true
}

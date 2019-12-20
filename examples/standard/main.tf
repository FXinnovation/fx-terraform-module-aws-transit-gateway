provider "aws" {
  version    = "~> 2.18"
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key

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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_route_table" "selected" {
  vpc_id = data.aws_vpc.default.id
}

module "standard" {
  source = "../../"

  vpc_id = data.aws_vpc.default.id

  tags = {
    Terraform = "test"
  }

  prefix              = "tftest${random_string.this.result}TGW"
  description         = "Terraform test Transit Gateway"
  subnet_ids          = data.aws_subnet_ids.all.ids
  vpc_route_table_ids = [data.aws_route_table.selected.id]
  vpc_routes_update   = false

  vpc_attachement_tags = {
    foo = "bar"
  }

  resource_share_create = false
}

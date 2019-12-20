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

module "no_gateway" {
  source = "../../"

  enable = false
}

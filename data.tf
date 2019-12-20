data "aws_ec2_transit_gateway" "this" {
  count = var.enable ? 1 : 0

  id = var.id == "" ? element(concat(aws_ec2_transit_gateway.this.*.id, [""]), 0) : var.id
}

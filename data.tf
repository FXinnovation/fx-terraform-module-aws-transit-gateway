data "aws_ec2_transit_gateway" "this" {
  id = "${var.id == "" ? element(concat(aws_ec2_transit_gateway.this.*.id, list("")), 0) : var.id}"
}

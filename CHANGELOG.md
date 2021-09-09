# Changelog
## 2.0.0

* (BREAKING) chore: pins `pre-commit-hooks` to `v4.0.1`.
* feat: add `pre-commit-afcmf` (`v0.1.2`).
* feat: add `LICENSE` file.
* chore: pins `pre-commit-terraform` to `v1.50.0`.
* chore: pins `terraform` to `>= 0.14`.
* chore: pins `aws` provider to `>= 3.0`.
* chore: bumps `terraform` + providers versions in example:
  * pins `terraform` to `>= 0.14`.
  * pins `aws` provider to `>= 3.0`.
  * pins `random` provider to `>= 3.0`.
* refactor: example test cases:
  * update `README.md` files.
  * update `providers.tf` files.
  * update `versions.tf` files with proper version contraints.
* refactor: lint code in root module.

## 1.1.0

* feat: Add custom transit gateway ASN id

## 1.0.1

* Fix float / whole number in `aws_route.this_vpc_routes` & `aws_route.this_vpn_routes`

## 1.0.0

* Upgrade to terraform 0.12

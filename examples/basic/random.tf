# see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "prefix" {
  length  = 4
  lower   = true
  numeric = false
  upper   = false
  special = false
}

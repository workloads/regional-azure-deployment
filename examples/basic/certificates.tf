# Generate a new private key and public key pair at runtime (as opposed to adding an existing key pair to the repository)
# see https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

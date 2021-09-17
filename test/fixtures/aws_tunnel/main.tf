provider aws {
    region = var.region
}

#
# Create a random id
#
resource "random_id" "id" {
  byte_length = 2
}
#
# Create random password for BIG-IP
#
resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "tls_private_key" "keypair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "local_file" "privatekey" {
  content         = tls_private_key.keypair.private_key_pem
  filename        = format("%s-%s.pem", var.prefix, terraform.workspace)
  file_permission = "0600"
}
resource "aws_key_pair" "deployer" {
  key_name_prefix = format("%s-%s", var.prefix, terraform.workspace)
  public_key      = tls_private_key.keypair.public_key_openssh
}
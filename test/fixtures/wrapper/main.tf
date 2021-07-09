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
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = random_password.password.result
  bigip_address    = module.bigip[0].mgmtPublicIP[0]
  bigip_do_payload = "${file("${path.module}/../../assets/do.json")}"
}
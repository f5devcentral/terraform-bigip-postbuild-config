module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = random_password.password.result
  bigip_address    = azurerm_public_ip.management_public_ip[0].ip_address
  bigip_do_payload = "${file("${path.module}/../../assets/do.json")}"
  depends_on = [
    azurerm_virtual_machine.f5bigip
  ]
}
module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = random_password.password.result
  bigip_address    = module.bigip[0].mgmtPublicIP[0]
  bigip_do_payload = templatefile("${path.module}/../../assets/do.json",{ nameserver = var.nameserver })
  depends_on = [
    module.bigip
  ]
}
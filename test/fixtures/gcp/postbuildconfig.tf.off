module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = module.bigip[0].f5_username
  bigip_password   = module.bigip[0].bigip_password
  bigip_address    = module.bigip[0].mgmtPublicIP
  bigip_do_payload = templatefile("${path.module}/../../assets/do_gcp.json", { nameserver = var.nameserver })
  depends_on = [
    module.bigip
  ]
}
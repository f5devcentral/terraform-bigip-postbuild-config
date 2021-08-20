module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = random_string.password.result
  bigip_address    = module.bigip[0].mgmtPublicIP[0]
  bigip_do_payload = templatefile("${path.module}/../../assets/do.json",{ nameserver = var.nameserver })
  depends_on = [
    module.bigip
  ]
}

module "postbuild-config-sh" {
  source           = "../../..//sh"
  bigip_user       = "admin"
  bigip_password   = random_string.password.result
  bigip_address    = module.bigip[0].mgmtPublicIP[0]
  bigip_shell_payload = templatefile("${path.module}/../../assets/postbuild.sh",{ maxclients = 20, mergeinterval = 10 })
  depends_on = [
    module.postbuild-config-do
  ]
}
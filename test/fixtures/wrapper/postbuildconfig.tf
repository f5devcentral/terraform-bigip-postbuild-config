module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = random_password.password.result
  bigip_address    = module.bigip[0].mgmtPublicIP[0]
  bigip_do_payload = "${file("${path.module}/../../assets/do.json")}"
  depends_on = [
    module.bigip
  ]
}
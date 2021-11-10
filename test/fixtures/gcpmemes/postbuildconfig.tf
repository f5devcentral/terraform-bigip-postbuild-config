module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = "N5F96YPskMWu8qTdvmN"
  bigip_address    = module.bigip.management_public_ips[0]
  bigip_do_payload = templatefile("${path.module}/../../assets/do_gcp.json", { nameserver = var.nameserver })
  depends_on = [
    module.bigip
  ]
}
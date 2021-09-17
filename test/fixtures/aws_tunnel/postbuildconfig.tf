module "postbuild-config-do" {
  count            = length(var.azs)
  source           = "../../..//do"
  bigip_user       = "admin"
  bigip_password   = random_string.password.result
  bigip_address    = module.bigip[count.index].mgmtPublicIP[0]
  bigip_do_payload = templatefile("${path.module}/../../assets/dotunnel.json",
      { 
        nameserver               = var.nameserver,
        internal_self            = module.bigip[count.index].private_addresses.internal_private.private_ip[0],
        internal_remote_self     = module.bigip[count.index == 0 ? 1 : 0].private_addresses.internal_private.private_ip[0],
        external_self            = module.bigip[count.index].private_addresses.public_private.private_ip[0],
        tunnel_overlay_address   = cidrhost("192.168.100.0/16",10 + count.index),
        default_gateway_address  = cidrhost(cidrsubnet("${module.bigip[count.index].private_addresses.public_private.private_ip[0]}/24",0,0),1),
        internal_gateway_address = cidrhost(cidrsubnet("${module.bigip[count.index].private_addresses.internal_private.private_ip[0]}/24",0,0),1),
        network_cidr             = var.cidr
      }
  )
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
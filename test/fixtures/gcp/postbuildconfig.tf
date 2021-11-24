module "postbuild-config-do" {
  source           = "../../..//do"
  bigip_user       = module.bigip[0].f5_username
  bigip_password   = module.bigip[0].bigip_password
  bigip_address    = module.bigip[0].mgmtPublicIP
  bigip_do_payload = templatefile("${path.module}/../../assets/do.json",   
  { 
    nameserver              = var.nameserver
    internal_selfip_address = var.internal_selfip_address
    external_selfip_address = var.external_selfip_address
    mtu_size                = var.mtu_size
    internal_vlan_tag       = var.internal_vlan_tag
    external_vlan_tag       = var.external_vlan_tag
    internal_vlan_name      = var.internal_vlan_name
    external_vlan_name      = var.external_vlan_name
    provision               = var.provision
  })
  depends_on = [
    module.bigip
  ]
}

module "postbuild-config-sh" {
  source           = "../../..//sh"
  bigip_user       = module.bigip[0].f5_username
  bigip_password   = module.bigip[0].bigip_password
  bigip_address    = module.bigip[0].mgmtPublicIP
  bigip_shell_payload = templatefile("${path.module}/../../assets/postbuild.sh",{ maxclients = 20, mergeinterval = 10 })
  depends_on = [
    module.postbuild-config-do
  ]
}
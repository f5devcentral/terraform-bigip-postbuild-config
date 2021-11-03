output "bigip_mgmt_port" {
    value = "443"
}

output "bigip_password" {
    value = module.bigip[0].bigip_password
}

output "key_name" {
    value = var.privatekeyfile
}

output bigip_address {
  value = module.bigip[0].mgmtPublicIP
}

output bigip_port {
  value = 443
}

output user {
  value = module.bigip[0].f5_username
}

output password {
  value     = module.bigip[0].bigip_password
  sensitive = true
}

output do_version {
  value = "1.21.0"
}

output as3_version {
  value = "3.28.0"
}

output ts_version {
  value = "1.20.0"
}

output fast_version {
  value = "1.9.0"
}

output nameserver {
  value = var.nameserver
}

output internal_selfip_address {
  value = var.internal_selfip_address
}
output external_selfip_address {
  value = var.external_selfip_address
}
output mtu_size {
  value = var.mtu_size # specifically for GCP 1500 for AWS and Azure
}
output internal_vlan_tag {
  value = var.internal_vlan_tag
}
output external_vlan_tag {
  value = var.external_vlan_tag
}
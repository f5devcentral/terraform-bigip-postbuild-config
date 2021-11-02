output bigip_password {
  value = module.bigip.*.bigip_password
}
output mgmtPublicIP {
  value = module.bigip[0].mgmtPublicIP
}

output bigip_username {
  value = module.bigip.*.f5_username
}
output mgmtPort {
  value = module.bigip.*.mgmtPort
}

output public_addresses {
  value = module.bigip.*.public_addresses
}
output private_addresses {
  value = module.bigip.*.private_addresses
}
output service_account {
  value = module.bigip.*.service_account
}
output bigip_port {
  value = module.bigip[0].mgmtPort
}
output bigip_address {
  value = module.bigip[0].mgmtPublicIP
}

output user {
  value = module.bigip[0].f5_username
}

output password {
  value     = module.bigip[0].bigip_password
  sensitive = true
}

output do_version {
  value = "1.25.0"
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
  value = "10.30.0.10/32"
}
output external_selfip_address {
  value = "10.20.0.9/32"
}
output mtu_size {
  value = 1460 # specifically for GCP 1500 for AWS and Azure
}
output internal_vlan_tag {
  value = "4093"
}
output external_vlan_tag {
  value = "4092"
}
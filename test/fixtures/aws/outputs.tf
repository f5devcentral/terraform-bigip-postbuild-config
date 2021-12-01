output "bigip_mgmt_public_ips" {
  description = "Public IP addresses for the BIG-IP management interfaces"
  value       = module.bigip[*].mgmtPublicIP 
}

output "bigip_password" {
  description = "BIG-IP management password"
  value       = random_string.password.result
  sensitive   = true
}

output bigip_address {
  value = module.bigip[0].mgmtPublicIP
}

output bigip_port {
  value = 443
}

output user {
  value = "admin"
}

output password {
  value     = random_string.password.result
  sensitive = true
}

output do_version {
  value = var.do_version
}

output as3_version {
  value = var.as3_version
}

output ts_version {
  value = var.ts_version
}

output fast_version {
  value = var.fast_version
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
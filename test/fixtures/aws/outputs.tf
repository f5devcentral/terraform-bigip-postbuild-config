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
  value = module.bigip[0].mgmtPublicIP[0]
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
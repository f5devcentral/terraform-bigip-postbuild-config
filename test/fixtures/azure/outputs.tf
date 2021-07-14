output "config" {
    value = data.azurerm_client_config.current
}

output "bigip_mgmt_public_ips" {
    value = azurerm_public_ip.management_public_ip[*].ip_address
}

output "bigip_mgmt_port" {
    value = "443"
}

output "bigip_password" {
    value = random_password.password.result
    sensitive = true
}

output "key_name" {
    value = var.privatekeyfile
}

output bigip_address {
  value = azurerm_public_ip.management_public_ip[0].ip_address
}

output bigip_port {
  value = 443
}

output user {
  value = "admin"
}

output password {
  value     = random_password.password.result
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
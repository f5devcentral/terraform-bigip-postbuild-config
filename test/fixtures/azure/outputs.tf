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


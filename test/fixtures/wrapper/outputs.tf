output "bigip_mgmt_public_ips" {
  description = "Public IP addresses for the BIG-IP management interfaces"
  value       = module.bigip[*].mgmtPublicIP 
}

output "bigip_password" {
  description = "BIG-IP management password"
  value       = random_password.password.result
  sensitive   = true
}
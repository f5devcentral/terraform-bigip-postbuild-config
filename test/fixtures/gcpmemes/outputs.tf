output bigip_password {
  value = ["N5F96YPskMWu8qTdvmN"]
}
output mgmtPublicIP {
  value = module.bigip.management_public_ips
}
output bigip_username {
  value = "admin"
}
output mgmtPort {
  value = "443"
}
output public_addresses {
  value = module.bigip.external_public_ips
}
output private_addresses {
  value = module.bigip.internal_addresses
}
output service_account {
  value = var.service_account
}

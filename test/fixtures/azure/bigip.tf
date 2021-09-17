module bigip {
  count                      = 1
  source                     = "git::git@github.com:f5devcentral/terraform-azure-bigip-module.git?ref=v0.9.8"
  prefix                     = format("%s-bigip-%s",var.prefix,random_id.id.hex)
  f5_ssh_publickey           = file("~/.ssh/id_rsa.pub")
  resource_group_name        = azurerm_resource_group.main.name
  mgmt_subnet_ids            = [{"subnet_id" =  data.azurerm_subnet.mgmt.id, "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  mgmt_securitygroup_ids     = [module.mgmt-network-security-group.network_security_group_id]
  external_subnet_ids        = [{ "subnet_id" = data.azurerm_subnet.external.id, "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  external_securitygroup_ids = [module.external-network-security-group.network_security_group_id]
  internal_subnet_ids        = [{ "subnet_id" = data.azurerm_subnet.internal.id, "public_ip" = false, "private_ip_primary" = "" }]
  internal_securitygroup_ids = [module.internal-network-security-group.network_security_group_id]
  availabilityZones          = var.azs
}


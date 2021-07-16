# Create virtual network
#
# Create the Network Module to associate with BIGIP
#

module "network" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = format("%s-vnet-%s", var.prefix, random_id.id.hex)
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.cidr]
  subnet_prefixes     = [cidrsubnet(var.cidr, 8, 1), cidrsubnet(var.cidr, 8, 2), cidrsubnet(var.cidr, 8, 3)]
  subnet_names        = ["mgmt-subnet", "external-subnet", "internal-subnet"]

  tags = {
    environment = "test"
    costcenter  = "it"
  }
}

data "azurerm_subnet" "mgmt" {
  name                 = "mgmt-subnet"
  virtual_network_name = module.network.vnet_name
  resource_group_name  = azurerm_resource_group.main.name
  depends_on           = [module.network]
}

data "azurerm_subnet" "external" {
  name                 = "external-subnet"
  virtual_network_name = module.network.vnet_name
  resource_group_name  = azurerm_resource_group.main.name
  depends_on           = [module.network]
}

data "azurerm_subnet" "internal" {
  name                 = "internal-subnet"
  virtual_network_name = module.network.vnet_name
  resource_group_name  = azurerm_resource_group.main.name
  depends_on           = [module.network]
}


#
# Create the Network Security group Module to associate with BIGIP-Mgmt-Nic
#
module mgmt-network-security-group {
  source              = "Azure/network-security-group/azurerm"
  resource_group_name = azurerm_resource_group.main.name
  security_group_name = format("%s-mgmt-nsg-%s", var.prefix, random_id.id.hex)
  tags = {
    environment = "test"
    costcenter  = "test"
  }
}

#
# Create the Network Security group Module to associate with BIGIP-External-Nic
#
module external-network-security-group {
  source              = "Azure/network-security-group/azurerm"
  resource_group_name = azurerm_resource_group.main.name
  security_group_name = format("%s-external-nsg-%s", var.prefix, random_id.id.hex)
  tags = {
    environment = "dev"
    costcenter  = "terraform"
  }
}

resource "azurerm_network_security_rule" "mgmt_allow_https" {
  name                        = "Allow_Https"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  destination_address_prefix  = "*"
  source_address_prefixes     = var.allowed_cidrs
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = format("%s-mgmt-nsg-%s", var.prefix, random_id.id.hex)
  depends_on                  = [module.mgmt-network-security-group]
}
resource "azurerm_network_security_rule" "mgmt_allow_ssh" {
  name                        = "Allow_ssh"
  priority                    = 202
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
  source_address_prefixes     = var.allowed_cidrs
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = format("%s-mgmt-nsg-%s", var.prefix, random_id.id.hex)
  depends_on                  = [module.mgmt-network-security-group]
}

resource "azurerm_network_security_rule" "external_allow_https" {
  name                        = "Allow_Https"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  destination_address_prefix  = "*"
  source_address_prefixes     = var.allowed_cidrs
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = format("%s-external-nsg-%s", var.prefix, random_id.id.hex)
  depends_on                  = [module.external-network-security-group]
}
resource "azurerm_network_security_rule" "external_allow_ssh" {
  name                        = "Allow_ssh"
  priority                    = 202
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
  source_address_prefixes     = var.allowed_cidrs
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = format("%s-external-nsg-%s", var.prefix, random_id.id.hex)
  depends_on                  = [module.external-network-security-group]
}
module "internal-network-security-group" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.main.name
  security_group_name   = format("%s-internal-nsg-%s", var.prefix, random_id.id.hex)
  source_address_prefix = ["10.0.3.0/24"]
  tags = {
    environment = "dev"
    costcenter  = "terraform"
  }
}
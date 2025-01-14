
locals {
  prefix = var.prefix == "" ? "" : format("%s-", var.prefix)
}

####################################################
# storage accounts (boot diagnostics)
####################################################

resource "random_id" "storage_accounts" {
  byte_length = 5
}

resource "azurerm_storage_account" "storage_accounts" {
  for_each                 = var.regions
  resource_group_name      = var.resource_group
  name                     = lower("${var.prefix}${each.key}${random_id.storage_accounts.hex}")
  location                 = each.value
  account_replication_type = "LRS"
  account_tier             = "Standard"
  tags                     = var.tags
}

# ####################################################
# # log analytics workspace
# ####################################################

# resource "random_id" "analytics_workspaces" {
#   byte_length = 5
# }

# resource "azurerm_log_analytics_workspace" "analytics_workspaces" {
#   for_each            = var.regions
#   resource_group_name = var.resource_group
#   name                = "${local.prefix}${each.key}-analytics-ws-${random_id.analytics_workspaces.hex}"
#   location            = each.value
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
#   tags                = var.tags
# }

# locals {
#   firewall_categories_metric = ["AllMetrics"]
#   firewall_categories_log = [
#     "AzureFirewallApplicationRule",
#     "AzureFirewallNetworkRule",
#     "AzureFirewallDnsProxy"
#   ]
# }

####################################################
# nsg
####################################################

# default
#----------------------------

resource "azurerm_network_security_group" "nsg_default" {
  for_each            = var.regions
  resource_group_name = var.resource_group
  name                = "${local.prefix}nsg-${each.value}-default"
  location            = each.value
  tags                = var.tags
}

# vm
#----------------------------

resource "azurerm_network_security_group" "nsg_main" {
  for_each            = var.regions
  resource_group_name = var.resource_group
  name                = "${local.prefix}nsg-${each.key}-main"
  location            = each.value
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_main_private_inbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_main[each.key].name
  name                        = "private-inbound"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100
  source_address_prefixes     = var.private_prefixes
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  protocol                    = "*"
  description                 = "Allow all private prefixes"
}

resource "azurerm_network_security_rule" "nsg_main_private_outbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_main[each.key].name
  name                        = "all-outbound"
  direction                   = "Outbound"
  access                      = "Allow"
  priority                    = 100
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  protocol                    = "*"
  description                 = "Allow all outbound"
}

# nva
#----------------------------

resource "azurerm_network_security_group" "nsg_nva" {
  for_each            = var.regions
  resource_group_name = var.resource_group
  name                = "${local.prefix}nsg-${each.value}-nva"
  location            = each.value
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_nva_private_inbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_nva[each.key].name
  name                        = "private-inbound"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100
  source_address_prefixes     = var.private_prefixes
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  protocol                    = "*"
  description                 = "Allow all private prefixes"
}

resource "azurerm_network_security_rule" "nsg_nva_ipsec_inbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_nva[each.key].name
  name                        = "allow-ipsec-inbound"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 110
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_ranges     = ["500", "4500"]
  protocol                    = "Udp"
  description                 = "Inbound Allow UDP 500, 4500"
}

resource "azurerm_network_security_rule" "nsg_nva_outbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_nva[each.key].name
  name                        = "all-outbound"
  direction                   = "Outbound"
  access                      = "Allow"
  priority                    = 100
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  protocol                    = "*"
  description                 = "Allow all outbound"
}

# appgw
#----------------------------

resource "azurerm_network_security_group" "nsg_appgw" {
  for_each            = var.regions
  resource_group_name = var.resource_group
  name                = "${local.prefix}nsg-${each.value}-appgw"
  location            = each.value
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_appgw_appgw_v2sku_inbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_appgw[each.key].name
  name                        = "allow-appgw-v2sku-inbound"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 200
  source_address_prefix       = "GatewayManager"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "65200-65535"
  protocol                    = "*"
  description                 = "Allow Inbound Azure infrastructure communication"
}

resource "azurerm_network_security_rule" "nsg_appgw_web_external_inbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_appgw[each.key].name
  name                        = "allow-web-external-inbound"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 210
  source_address_prefix       = "0.0.0.0/0"
  source_port_range           = "*"
  destination_address_prefix  = "VirtualNetwork"
  destination_port_ranges     = ["80", "8080", "443"]
  protocol                    = "Tcp"
  description                 = "Allow inbound web traffic"
}

resource "azurerm_network_security_rule" "nsg_appgw_outbound" {
  for_each                    = var.regions
  resource_group_name         = var.resource_group
  network_security_group_name = azurerm_network_security_group.nsg_appgw[each.key].name
  name                        = "all-outbound"
  direction                   = "Outbound"
  access                      = "Allow"
  priority                    = 100
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "*"
  protocol                    = "*"
  description                 = "Allow all outbound"
}

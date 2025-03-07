resource "azurerm_virtual_network" "n01701496-vnet" {
  name                = var.vnet_name
  resource_group_name = var.n01701496_rg_name
  location            = var.location
  address_space       = [var.vnet_space]
  tags = var.tags
}

resource "azurerm_subnet" "n01701496-subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.n01701496_rg_name
  virtual_network_name = azurerm_virtual_network.n01701496-vnet.name
  address_prefixes     = [var.subnet_address_space]
 
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.n01701496_rg
  location            = var.location
  tags = var.tags
  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule3"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule4"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-n01701496-subnet-association" {
  subnet_id                 = azurerm_subnet.n01701496-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

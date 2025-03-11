# Create a public IP for the load balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "n01701496-lb-public-ip"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  allocation_method   = "Static"
  sku                  = "Basic"

  tags = var.tags
}

# Create the load balancer
resource "azurerm_lb" "n01701496_lb" {
  name                = "n01701496_lb"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  sku                  = "Basic"

  frontend_ip_configuration {
    name                 = "n01701496_frontend_ip_configuration"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = var.tags
}

# Create a backend pool and associate the Linux VMs
resource "azurerm_lb_backend_address_pool" "n01701496_lb_backend" {
  name                = "n01701496_lb_backend"
  loadbalancer_id     = azurerm_lb.n01701496_lb.id
}

# Attach the 3 Linux VMs to the backend pool
resource "azurerm_network_interface_backend_address_pool_association" "linux_vms" {
  count              = length(var.vm_network_interface_ids)
  network_interface_id  = element(var.vm_network_interface_ids, count.index)
  ip_configuration_name = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.n01701496_lb_backend.id
}



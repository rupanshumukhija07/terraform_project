# Create a public IP for the load balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "n01701496-lb-public-ip"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = var.dns_label
  tags = var.tags
}

# Create the load balancer
resource "azurerm_lb" "n01701496_lb" {
  name                = "n01701496_lb"
  location            = var.location
  resource_group_name = var.n01701496_rg_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "n01701496_frontend_ip_configuration"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = var.tags
}

# Create a backend address pool
resource "azurerm_lb_backend_address_pool" "n01701496_lb_backend" {
  name            = "n01701496_lb_backend"
  loadbalancer_id = azurerm_lb.n01701496_lb.id
}

# Associate Linux VM NICs to backend pool
resource "azurerm_network_interface_backend_address_pool_association" "linux_vms" {
  count                    = length(var.vm_network_interface_ids)
  network_interface_id     = element(var.vm_network_interface_ids, count.index)
  ip_configuration_name    = "internal"  # Must match name in your NIC definition
  backend_address_pool_id  = azurerm_lb_backend_address_pool.n01701496_lb_backend.id
}

# Create a health probe on port 80
resource "azurerm_lb_probe" "http_probe" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.n01701496_lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Create a load balancer rule for port 80
resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.n01701496_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "n01701496_frontend_ip_configuration"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.n01701496_lb_backend.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}
output "loadbalancer_name" {
  description = "The name of the load balancer"
  value       = azurerm_lb.n01701496_lb.name
}

output "loadbalancer_public_ip" {
  description = "Public IP of the load balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

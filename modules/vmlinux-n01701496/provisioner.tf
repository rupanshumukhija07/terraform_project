
# Display hostnames using remote-exec
resource "null_resource" "display_hostnames" {
  for_each = var.linux_name
  provisioner "remote-exec" {
    inline = [  
       "echo 'Running on:'",
      "/usr/bin/hostname", #since this hostname command is not working, uname -a will give the same details.
      "echo 'System Info:'",
      "uname -a"]
  }
  connection {
    type     = "ssh"
    user     = var.admin_username
    private_key = file(var.private_key_path)
    host     = azurerm_public_ip.linux_pip[each.key].ip_address
  }
  depends_on = [azurerm_linux_virtual_machine.linux_vm]
}
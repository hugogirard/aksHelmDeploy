

resource "azurerm_network_interface" "vm_nic" {
  name                = "jumpbox-nic"
  location            = var.location
  resource_group_name = var.resourceGroupName
  count = "${var.enabled == "true" ? 1 : 0}"

  ip_configuration {
    name                          = "jumpboxipconf"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                            = "jumpboxvm"
  location                        = var.location
  resource_group_name             = var.resourceGroupName
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]
  size                            = "Standard_DS1_v2"
  computer_name                   = "jumpboxvm"
  admin_username                  = var.vm_user
  admin_password                  = var.vm_password
  disable_password_authentication = false
  count = "${var.enabled == "true" ? 1 : 0}"
  
  os_disk {
    name                 = "jumpboxOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  provisioner "remote-exec" {
    connection {
      host     = self.public_ip_address
      type     = "ssh"
      user     = var.vm_user
      password = var.vm_password
    }

    inline = [
      "sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2",
      "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -",
      "echo 'deb https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee -a /etc/apt/sources.list.d/kubernetes.list",
      "sudo apt-get update",
      "sudo apt-get install -y kubectl",
      "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash",
      "curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3",
      "sudo chmod 700 get_helm.sh",
      "sudo ./get_helm.sh"
    ]
  }    
}
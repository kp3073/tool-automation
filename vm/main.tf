resource "azurerm_public_ip" "main" {
  name                = var.component
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Dynamic"
  sku = "basic"

  tags = {
	environment = var.component
  }
}

resource "azurerm_network_security_group" "main" {
  name                = var.component
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
	name                       = "ssh"
	priority                   = 100
	direction                  = "Inbound"
	access                     = "Allow"
	protocol                   = "Tcp"
	source_port_range          = "22"
	destination_port_range     = "22"
	source_address_prefix      = "*"
	destination_address_prefix = "*"
  }

  security_rule {
	name                       = "vault"
	priority                   = 101
	direction                  = "Inbound"
	access                     = "Allow"
	protocol                   = "Tcp"
	source_port_range          = var.port
	destination_port_range     = var.port
	source_address_prefix      = "*"
	destination_address_prefix = "*"
  }
  
  tags = {
	environment = var.component
  }
}

resource "azurerm_network_interface" "main" {
  name                = var.component
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
	name                          = "internal"
	subnet_id                     = data.azurerm_subnet.main.id
	private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_virtual_machine" "main" {
  depends_on = [azurerm_network_interface_security_group_association.main,]
  name                = var.component
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size = "Standard_DS1_v2"
  

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
	id = "/subscriptions/4b236e6d-2c9a-4cb2-90a2-30a5377d8eb2/resourceGroups/azuredevops/providers/Microsoft.Compute/galleries/azawsdevops/images/azawsdevops/versions/1.0.0"
  }
  storage_os_disk {
	name              = var.component
	caching           = "ReadWrite"
	create_option     = "FromImage"
	managed_disk_type = "Standard_LRS"
  }
  os_profile {
	computer_name  = var.component
	admin_username = var.ssh_username
	admin_password = var.ssh_password
  }
  os_profile_linux_config {
	disable_password_authentication = false
  }
  tags = {
	environment = var.component
  }
  
}
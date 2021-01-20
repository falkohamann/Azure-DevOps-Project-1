provider "azurerm" {
  subscription_id = var.azure-subscription-id
  client_id       = var.azure-client-id
  client_secret   = var.azure-client-secret
  tenant_id       = var.azure-tenant-id

  features {}
}

#Create a Resource Group
resource "azurerm_resource_group" "resource-group" {  
    name = "${var.prefix}-rg"  
    location = var.location     

    tags = {
    environment = "udacity-deploy"
    }
}  

#Create a virtual Network and a subnet on that virtual network
resource "azurerm_virtual_network" "virtual-network" {
  name                = "${var.prefix}-vn"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "udacity-deploy"
    }
}
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-sn"
  resource_group_name  = azurerm_resource_group.resource-group.name
  virtual_network_name = azurerm_virtual_network.virtual-network.name
  address_prefixes     = ["10.0.1.0/24"]
}
#Create NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-sg"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name

  tags = {
    environment = "udacity-deploy"
    }

  security_rule {
    name                       = "deny-internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
    source_port_range           = "*"
    destination_port_range      = "*"
  }

  security_rule {
    name                       = "allow-vnet"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    source_port_range           = "*"
    destination_port_range      = "*"
  }
}
  #Create a NIC
  resource "azurerm_network_interface" "nic" {
  count = var.vm-count

  name                = "${var.prefix}-nic-${count.index}"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    }

  tags = {
    environment = "udacity-deploy"
    }

  } 
  #Create a Public IP
  resource "azurerm_public_ip" "publicIP" {
  name                = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.resource-group.name
  location            = azurerm_resource_group.resource-group.location
  allocation_method   = "Static"

  tags = {
    environment = "udacity-deploy"
    }
  }
  #Create a LoadBalancer
  resource "azurerm_lb" "load-balancer" {
  name                = "${var.prefix}-lb"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name

  tags = {
    environment = "udacity-deploy"
    }

  frontend_ip_configuration {
    name                 = "${var.prefix}-lb-fip"
    public_ip_address_id = azurerm_public_ip.publicIP.id
  }
  }
  resource "azurerm_lb_backend_address_pool" "lb-backend-addr-pool" {
  resource_group_name = azurerm_resource_group.resource-group.name
  loadbalancer_id     = azurerm_lb.load-balancer.id
  name                = "${var.prefix}-lb-backend-addr-pool"
  
  }
  resource "azurerm_network_interface_backend_address_pool_association" "backend-addr-pool-association" {
  count = var.vm-count
  
  network_interface_id    = element(azurerm_network_interface.nic.*.id, count.index)
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb-backend-addr-pool.id

}
  #Create a Availability Set
  resource "azurerm_availability_set" "availability-set" {
  name                = "${var.prefix}-aset"
  location            = azurerm_resource_group.resource-group.location
  resource_group_name = azurerm_resource_group.resource-group.name

  tags = {
    environment = "udacity-deploy"
  }
}
resource "azurerm_linux_virtual_machine" "vm" {
  count = var.vm-count

  name                            = "${var.prefix}-vm-${count.index}"
  location                        = azurerm_resource_group.resource-group.location
  resource_group_name             = azurerm_resource_group.resource-group.name
  size                            = "Standard_B1ls"
  admin_username                  = "azure-admin"
  admin_password                  = "Udacity123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]
  availability_set_id = azurerm_availability_set.availability-set.id
  source_image_id     = var.os-image

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    environment = "udacity-deploy"
  }
}
#Create managed disk for each vm
resource "azurerm_managed_disk" "m-disk" {
  name                            = "${var.prefix}-md"
  location                        = azurerm_resource_group.resource-group.location
  resource_group_name             = azurerm_resource_group.resource-group.name
  storage_account_type            = "Standard_LRS"
  create_option                   = "Empty"
  disk_size_gb                    = "1"

  tags = {
    environment = "udacity-deploy"
  }
}
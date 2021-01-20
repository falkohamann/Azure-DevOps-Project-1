# Azure-DevOps-Project-1

## Introduction

Your company's development team has created an application that they need deployed to Azure. The application is self-contained, but they need the infrastructure to deploy it in a customizable way based on specifications provided at build time, with an eye toward scaling the application for use in a CI/CD pipeline.

Although we’d like to use Azure App Service, management has told us that the cost is too high for a PaaS like that and wants us to deploy it as pure IaaS so we can control cost. Since they expect this to be a popular service, it should be deployed across multiple virtual machines.

To support this need and minimize future work, we will use Packer to create a server image, and Terraform to create a template for deploying a scalable cluster of servers—with a load balancer to manage the incoming traffic. We’ll also need to adhere to security practices and ensure that our infrastructure is secure.

## Requirements
- an Azure Account
- installation of the latest version of Terraform
- installation of the latest version of Packer
- installation of the latest version of AzureCLI

## Instructions

### To allow login for Packer and Terraform we need to create a service principal in Azure

    Create service principal for Terraform and Packer 

### Create a Resource group in Azure and update the config files

    Add the name of the ressource group to the server.json file and the vars.tf file

### Deploy the packer image
    Add your service principal data to the following lines in the server.jsoon file:
    
    "client_id": "",
    "client_secret": "",
     subscription_id": "",
     
     Run Packer
        
        packer build server.json

### Create resources with Terraform
    
    Update the vars.tf variable file to configure terraform
    
    Create a file terraform.tfvars with secret information
    
        # Azure Subscription Id
        azure-subscription-id = "XXX"
        # Azure Client Id/appId
        azure-client-id = "XXX"
        # Azure Client Secret/password
        azure-client-secret = "XXX"
        # Azure Tenant Id
        azure-tenant-id = "XXX"
        
    Run Terraform to create the ressources
    
        terraform plan
        terraform apply
        
## Expected Output

    terraform apply .\solution.plan
azurerm_resource_group.resource-group: Creating...
azurerm_resource_group.resource-group: Creation complete after 2s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg]
azurerm_availability_set.availability-set: Creating...
azurerm_public_ip.publicIP: Creating...
azurerm_managed_disk.m-disk: Creating...
azurerm_virtual_network.virtual-network: Creating...
azurerm_network_security_group.nsg: Creating...
azurerm_public_ip.publicIP: Creation complete after 3s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/publicIPAddresses/udacity-deploy-pip]
azurerm_lb.load-balancer: Creating...
azurerm_managed_disk.m-disk: Creation complete after 4s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Compute/disks/udacity-deploy-md]
azurerm_virtual_network.virtual-network: Creation complete after 5s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/virtualNetworks/udacity-deploy-vn]
azurerm_subnet.subnet: Creating...
azurerm_network_security_group.nsg: Creation complete after 5s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/networkSecurityGroups/udacity-deploy-sg]
azurerm_lb.load-balancer: Creation complete after 2s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/loadBalancers/udacity-deploy-lb]
azurerm_lb_backend_address_pool.lb-backend-addr-pool: Creating...
azurerm_availability_set.availability-set: Creation complete after 6s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Compute/availabilitySets/udacity-deploy-aset]
azurerm_lb_backend_address_pool.lb-backend-addr-pool: Creation complete after 1s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/loadBalancers/udacity-deploy-lb/backendAddressPools/udacity-deploy-lb-backend-addr-pool]
azurerm_subnet.subnet: Creation complete after 4s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/virtualNetworks/udacity-deploy-vn/subnets/udacity-deploy-sn]
azurerm_network_interface.nic[1]: Creating...
azurerm_network_interface.nic[0]: Creating...
azurerm_network_interface.nic[0]: Creation complete after 2s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/networkInterfaces/udacity-deploy-nic-0]
azurerm_network_interface.nic[1]: Creation complete after 3s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/networkInterfaces/udacity-deploy-nic-1]
azurerm_network_interface_backend_address_pool_association.backend-addr-pool-association[0]: Creating...
azurerm_network_interface_backend_address_pool_association.backend-addr-pool-association[1]: Creating...
azurerm_linux_virtual_machine.vm[0]: Creating...
azurerm_linux_virtual_machine.vm[1]: Creating...
azurerm_network_interface_backend_address_pool_association.backend-addr-pool-association[1]: Creation complete after 1s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/networkInterfaces/udacity-deploy-nic-1/ipConfigurations/internal|/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/loadBalancers/udacity-deploy-lb/backendAddressPools/udacity-deploy-lb-backend-addr-pool]
azurerm_network_interface_backend_address_pool_association.backend-addr-pool-association[0]: Creation complete after 1s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/networkInterfaces/udacity-deploy-nic-0/ipConfigurations/internal|/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Network/loadBalancers/udacity-deploy-lb/backendAddressPools/udacity-deploy-lb-backend-addr-pool]
azurerm_linux_virtual_machine.vm[0]: Still creating... [10s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [10s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [20s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [20s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [30s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [30s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [40s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [40s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [50s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [50s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [1m0s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [1m0s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [1m10s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [1m10s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [1m20s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [1m20s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [1m30s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [1m30s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [1m40s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [1m40s elapsed]
azurerm_linux_virtual_machine.vm[0]: Still creating... [1m50s elapsed]
azurerm_linux_virtual_machine.vm[1]: Still creating... [1m50s elapsed]
azurerm_linux_virtual_machine.vm[0]: Creation complete after 1m53s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Compute/virtualMachines/udacity-deploy-vm-0]
azurerm_linux_virtual_machine.vm[1]: Creation complete after 1m53s [id=/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Compute/virtualMachines/udacity-deploy-vm-1]

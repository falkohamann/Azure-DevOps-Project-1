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

### Create resources with Terraform

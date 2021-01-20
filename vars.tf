# Azure Subscription Id
variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription Id"
}
# Azure Client Id/appId
variable "azure-client-id" {
  type        = string
  description = "Azure Client Id/appId"
}
# Azure Client Id/appId
variable "azure-client-secret" {
  type        = string
  description = "Azure Client Id/appId"
}
# Azure Tenant Id
variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant Id"
}
#Azure location
variable "location" {
  description = "Azure region"
  default = "West Europe" 
}
#Prefix for this project
variable "prefix" {
  description = "prefix for all ressources in that project"
  default     = "udacity-deploy"
}
#vm count
variable "vm-count" {
}
#VM server names
variable "vm-name" {
  description = "main name for vms"
  default     = "linux-"
}
#OS Image Name provided by packer
variable "os-image" {
  description = "main name for vms"
  default     = "/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/deploy-rg/providers/Microsoft.Compute/images/Ubuntu-Image"
  #"/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/deploy-rg/providers/Microsoft.Compute/images/Ubuntu-Image"
  #"/subscriptions/d2cac56e-5263-4149-8d9d-964cf5cd8ed5/resourceGroups/udacity-deploy-rg/providers/Microsoft.Compute/images/Ubuntu-Image"
}
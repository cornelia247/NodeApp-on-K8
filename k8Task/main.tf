terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.83.0" 
    }
  }
}
data "azurerm_key_vault_secret" "serviceprinciple-id" {
  name         = var.serviceprinciple-id
  key_vault_id = module.KeyVault.key_vault_id
}

data "azurerm_key_vault_secret" "serviceprinciple-secret" {
  name         = var.serviceprinciple-secret
  key_vault_id = module.KeyVault.key_vault_id  
}

data "azurerm_key_vault_secret" "sshKey" {
  name         = var.sshKey
  key_vault_id = module.KeyVault.key_vault_id  
}

locals {
  ssh_key_string = tostring(data.azurerm_key_vault_secret.sshKey.value)
}

provider "azurerm" {

  subscription_id = var.subscription_id
  # client_id = data.azurerm_key_vault_secret.serviceprinciple-id.value
  # client_secret = data.azurerm_key_vault_secret.serviceprinciple-secret.value
  tenant_id = var.tenant_id 

  features {}
}

resource "azurerm_resource_group" "K8sOvertake" {
  name     = "K8sOvertake"
  location = "West Europe"
}

module "AKS" {
  source = "./modules/AKS"
  serviceprinciple-id = data.azurerm_key_vault_secret.serviceprinciple-id.value
  serviceprinciple-secret = data.azurerm_key_vault_secret.serviceprinciple-secret.value
  sshKey = local.ssh_key_string
  location = azurerm_resource_group.K8sOvertake.location
  environment = var.environment
  resource_group_name = azurerm_resource_group.K8sOvertake.name

}

module "KeyVault" {
  source = "./modules/KeyVault"
  location = azurerm_resource_group.K8sOvertake.location
  resource_group_name = azurerm_resource_group.K8sOvertake.name
  tenant_id = var.tenant_id 
}
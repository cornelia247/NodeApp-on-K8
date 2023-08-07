resource "azurerm_key_vault" "kubertakeovrvault" {
  name                = "kubertakeovrvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"     
  tenant_id           = var.tenant_id  

  tags = {
    Environment = var.environment
  }
}

# Define variables, locals, and other resources specific to this module

# ...

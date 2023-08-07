

resource "azurerm_kubernetes_cluster" "K8sOvertake-cluster" {
  name                = "K8sOvertake-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "K8sOvertake"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_E4s_v3"
    type = "VirtualMachineScaleSets"
    os_disk_size_gb = 250
  }

  service_principal {
    client_id     = var.serviceprinciple-id
    client_secret = var.serviceprinciple-secret
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.sshKey
    }
  }

  network_profile {
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
  }
  tags = {
    Environment = "${var.environment}"
  }

}

resource "azurerm_container_registry" "KuberTakeovrcontainer" {
  name                = "kubertakeovrcontainer"
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_enabled       = false
  sku                 = "Basic"
}

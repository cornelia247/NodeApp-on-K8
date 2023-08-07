
output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.K8sOvertake-cluster.name
}

output "acr_name" {
  value = azurerm_container_registry.KuberTakeovrcontainer.name
}

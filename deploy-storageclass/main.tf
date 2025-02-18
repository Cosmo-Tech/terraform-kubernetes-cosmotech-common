resource "kubernetes_storage_class" "cosmotech-azure-retain" {
  count = var.storageclass_azure_deploy ? 1 : 0
  metadata {
    name = "cosmotech-retain"
  }
  storage_provisioner    = var.storageclass_provisioner_azure
  reclaim_policy         = "Retain"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"
}

resource "kubernetes_storage_class" "cosmotech-bare-retain" {
  count = var.storageclass_bare_deploy ? 1 : 0
  metadata {
    name = "cosmotech-retain"
  }
  storage_provisioner    = var.storageclass_provisioner_bare
  reclaim_policy         = "Retain"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"
}

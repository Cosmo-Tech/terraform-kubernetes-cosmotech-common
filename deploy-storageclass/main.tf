resource "kubernetes_storage_class" "cosmotech-azure-retain" {
  count = var.storageclass_azure_deploy ? 1 : 0
  metadata {
    name = "cosmotech-azure-retain"
  }
  storage_provisioner    = "disk.csi.azure.com"
  reclaim_policy         = "Retain"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"
}

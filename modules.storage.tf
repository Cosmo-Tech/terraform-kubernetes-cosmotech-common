module "deploy-storageclass" {

  source = "./create-storageclass"

  storageclass_azure_deploy           = var.storageclass_azure_deploy
  storageclass_bare_deploy            = var.storageclass_bare_deploy
  storageclass_provisioner_azure      = var.storageclass_provisioner_azure
  storageclass_provisioner_azure_file = var.storageclass_provisioner_azure_file
  storageclass_provisioner_bare       = var.storageclass_provisioner_bare
}

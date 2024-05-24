terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.0.4"
    }
  }

  backend "azurerm" {
    resource_group_name  = "arch5"
    storage_account_name = "arch5terraform"
    container_name       = "ganymede"
    key                  = "terraform-core.tfstate"
    access_key           = "4deHYErky3mQV5O8a9eZBNq2kzE8s3HYrVZXAeH07O5Ku/30hpIqMdgH1XWLCKNnXW8yZsrClhb3+AStPgaaZA=="
  }

  required_version = ">= 1.3.9"
}
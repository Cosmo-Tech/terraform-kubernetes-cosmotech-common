# Summary

## Azure Subscription

name  | value
------- | --------
Azure Subscription Id        | ${subscription_id}
Azure Subscription Name      | ${subscription_name}
Azure Resource Group Name    | ${azure_resource_group}

## Kubernetes Core Information

name  | value
------- | --------
Kubernetes Cluster Name      | ${kubernetes_cluster_name}
Kubernetes Cluster Version   | ${kubernetes_cluster_version}
Region                       | ${cluster_region}
Virtual Network Name         | ${network_name}
Public IP Name               | ${network_publicip_name}
Public IP Address            | ${network_publicip_address}

## Node Pool Core Information

name  | value | max
------- | -------- | --------
Node Pool System             | ${kubernetes_system_node_pool_vm}            | 3
Node Pool Services           | ${kubernetes_nodepool_vm_services}           | 2
Node Pool Monitoring         | ${kubernetes_nodepool_vm_monitoring}         | 3
Node Pool highmemory         | ${kubernetes_nodepool_vm_highmemory}         | 1
Node Pool highcpu            | ${kubernetes_nodepool_vm_highcpy}            | 1
Node Pool database           | ${kubernetes_nodepool_vm_database}           | 7
Node Pool basic              | ${kubernetes_nodepool_vm_basic}              | 2

## Core Services Status

name  | Deployed | Version
------- | -------- | --------
ArgoCD                | ${argocd_deploy == "true" ? "✅" : "❌"} | ${argocd_version}
Vault                 | ${vault_deploy == "true" ? "✅" : "❌" } | ${vault_version}
Vault SOPS            | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
Cert Manager          | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
Kube-Prometheus-Stack | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
Loki                  | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
Ingress Nginx         | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
RabbitMQ              | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
MinIO                 | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}

## Cluster Monitoring

Service  | Deployed | URL
------- | -------- | --------
Grafana | ${grafana_deploy == "true" ? "✅" : "❌"} | <https://${api_dns_name}/monitoring>

## tenant information

name  | value
------- | --------
Container Registry           | <${out_acr_login_server_url}>
Azure Cluster Name           | ${out_adx_cluster_name}
Azure Cluster Principal Id   | ${out_adx_cluster_principal_id}
Azure Cluster URI            | <${out_adx_cluster_uri}>
Cosmo Tech API URL           | <${out_api_cosmo_url}>
Cosmo Tech API Scope         | <${out_api_cosmo_scope}>
Api DNS Name                 | ${api_dns_name}

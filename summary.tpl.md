# Summary

## Azure Subscription

name  | value
------- | --------
Azure Subscription Id | ${subscription_id}
Azure Resource Group Name | ${azure_resource_group}

## Kubernetes Core Information

name  | value
------- | --------
Kubernetes Cluster Name | ${kubernetes_cluster_name}
Kubernetes Cluster Version | ${kubernetes_cluster_version}
Region | ${cluster_region}
Virtual Network Name | ${network_name}
Public IP Name | ${network_publicip_name}
Public IP Address | ${network_publicip_address}
Service Principal Network Name |  ${network_app_name}
Service Principal Network Client Id |  ${network_sp_client_id}
Service Principal Network Object Id |  ${network_sp_object_id}

## Node Pool Core Information

name  | type | min | max
------- | -------- | -------- | --------
System | ${kubernetes_nodepool_vm_system} | ${kubernetes_nodepool_vm_min_system} | ${kubernetes_nodepool_vm_max_system}
Basic | ${kubernetes_nodepool_vm_basic} | ${kubernetes_nodepool_vm_basic_min} | ${kubernetes_nodepool_vm_basic_max}
Services | ${kubernetes_nodepool_vm_services} | ${kubernetes_nodepool_vm_services_min} | ${kubernetes_nodepool_vm_services_max}
Database | ${kubernetes_nodepool_vm_database} | ${kubernetes_nodepool_vm_database_min} | ${kubernetes_nodepool_vm_database_max}
Monitoring | ${kubernetes_nodepool_vm_monitoring} | ${kubernetes_nodepool_vm_monitoring_min}  | ${kubernetes_nodepool_vm_monitoring_max}
Highcpu | ${kubernetes_nodepool_vm_highcpu} | ${kubernetes_nodepool_vm_highcpu_min} | ${kubernetes_nodepool_vm_highcpu_max}
Highmemory | ${kubernetes_nodepool_vm_highmemory} | ${kubernetes_nodepool_vm_highmemory_min} | ${kubernetes_nodepool_vm_highmemory_max}

## Core Services Status

name  | Deployed | Version
------- | -------- | --------
ArgoCD | ${argocd_deploy == "true" ? "✅" : "❌"} | ${argocd_version}
Vault | ${vault_deploy == "true" ? "✅" : "❌" } | ${vault_version}
Vault SOPS | ${sops_deploy == "true" ? "✅" : "❌"} | ${sops_version}
Cert Manager | ${certmanager_deploy == "true" ? "✅" : "❌"} | ${certmanager_version}
Kube Prometheus Stack | ${prom_deploy == "true" ? "✅" : "❌"} | ${prom_version}
Loki | ${loki_deploy == "true" ? "✅" : "❌"} | ${loki_version}
Ingress Nginx | ${nginx_deploy == "true" ? "✅" : "❌"} | ${nginx_version}

## Cluster Monitoring

Service  | Deployed | URL
------- | -------- | --------
Grafana | ${grafana_deploy == "true" ? "✅" : "❌"} | <https://${api_dns_name}/monitoring>

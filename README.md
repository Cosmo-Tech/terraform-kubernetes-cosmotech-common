<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.17.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 2.1.3 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.35.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert-manager"></a> [cert-manager](#module\_cert-manager) | ./create-cert-manager | n/a |
| <a name="module_create-ingress-nginx"></a> [create-ingress-nginx](#module\_create-ingress-nginx) | ./create-ingress-nginx | n/a |
| <a name="module_create-prometheus-stack"></a> [create-prometheus-stack](#module\_create-prometheus-stack) | ./create-prometheus-stack | n/a |
| <a name="module_create_argocd"></a> [create\_argocd](#module\_create\_argocd) | ./create_argocd | n/a |
| <a name="module_create_vault"></a> [create\_vault](#module\_create\_vault) | ./create_vault | n/a |
| <a name="module_create_vault_secrets_operator"></a> [create\_vault\_secrets\_operator](#module\_create\_vault\_secrets\_operator) | ./create-vault-secrets-operator | n/a |
| <a name="module_deploy-storageclass"></a> [deploy-storageclass](#module\_deploy-storageclass) | ./deploy-storageclass | n/a |
| <a name="module_deploy_velero"></a> [deploy\_velero](#module\_deploy\_velero) | ./create_velero | n/a |
| <a name="module_keycloak"></a> [keycloak](#module\_keycloak) | ./create-keycloak | n/a |
| <a name="module_loki"></a> [loki](#module\_loki) | ./create-loki | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster) | data source |
| [template_file.example](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [terraform_remote_state.core_dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.core_infra](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.core_ip](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_dns_name"></a> [api\_dns\_name](#input\_api\_dns\_name) | n/a | `string` | n/a | yes |
| <a name="input_argocd_create_ingress"></a> [argocd\_create\_ingress](#input\_argocd\_create\_ingress) | n/a | `bool` | n/a | yes |
| <a name="input_argocd_deploy"></a> [argocd\_deploy](#input\_argocd\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_argocd_helm_chart"></a> [argocd\_helm\_chart](#input\_argocd\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_argocd_helm_chart_version"></a> [argocd\_helm\_chart\_version](#input\_argocd\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_argocd_helm_release_name"></a> [argocd\_helm\_release\_name](#input\_argocd\_helm\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_argocd_helm_repo_url"></a> [argocd\_helm\_repo\_url](#input\_argocd\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_argocd_namespace"></a> [argocd\_namespace](#input\_argocd\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_argocd_project"></a> [argocd\_project](#input\_argocd\_project) | n/a | `string` | n/a | yes |
| <a name="input_argocd_replicas"></a> [argocd\_replicas](#input\_argocd\_replicas) | n/a | `number` | n/a | yes |
| <a name="input_argocd_repositories"></a> [argocd\_repositories](#input\_argocd\_repositories) | n/a | <pre>list(object({<br>    url      = string<br>    private  = bool<br>    token    = string<br>    username = string<br>  }))</pre> | n/a | yes |
| <a name="input_argocd_setup_job_image_version"></a> [argocd\_setup\_job\_image\_version](#input\_argocd\_setup\_job\_image\_version) | n/a | `string` | n/a | yes |
| <a name="input_auto_restart_deploy"></a> [auto\_restart\_deploy](#input\_auto\_restart\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_auto_restart_start_hours"></a> [auto\_restart\_start\_hours](#input\_auto\_restart\_start\_hours) | n/a | `number` | n/a | yes |
| <a name="input_auto_restart_start_minutes"></a> [auto\_restart\_start\_minutes](#input\_auto\_restart\_start\_minutes) | n/a | `number` | n/a | yes |
| <a name="input_cert_helm_release_name"></a> [cert\_helm\_release\_name](#input\_cert\_helm\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_cert_helm_repo_url"></a> [cert\_helm\_repo\_url](#input\_cert\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_cert_manager_version"></a> [cert\_manager\_version](#input\_cert\_manager\_version) | HELM Chart Version for cert-manager | `string` | n/a | yes |
| <a name="input_cert_namespace"></a> [cert\_namespace](#input\_cert\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_certificate_cert_content"></a> [certificate\_cert\_content](#input\_certificate\_cert\_content) | n/a | `string` | n/a | yes |
| <a name="input_certificate_key_content"></a> [certificate\_key\_content](#input\_certificate\_key\_content) | n/a | `string` | n/a | yes |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | n/a | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | n/a | `string` | n/a | yes |
| <a name="input_cluster_issuer_email"></a> [cluster\_issuer\_email](#input\_cluster\_issuer\_email) | n/a | `string` | n/a | yes |
| <a name="input_cluster_issuer_name"></a> [cluster\_issuer\_name](#input\_cluster\_issuer\_name) | n/a | `string` | n/a | yes |
| <a name="input_cluster_issuer_server"></a> [cluster\_issuer\_server](#input\_cluster\_issuer\_server) | The ACME server URL | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_grafana_loki_compatibility_image_tag"></a> [grafana\_loki\_compatibility\_image\_tag](#input\_grafana\_loki\_compatibility\_image\_tag) | n/a | `string` | n/a | yes |
| <a name="input_is_bare_metal"></a> [is\_bare\_metal](#input\_is\_bare\_metal) | n/a | `bool` | n/a | yes |
| <a name="input_keycloack_provisioner"></a> [keycloack\_provisioner](#input\_keycloack\_provisioner) | n/a | `string` | n/a | yes |
| <a name="input_keycloak_admin_user"></a> [keycloak\_admin\_user](#input\_keycloak\_admin\_user) | n/a | `string` | n/a | yes |
| <a name="input_keycloak_deploy"></a> [keycloak\_deploy](#input\_keycloak\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_keycloak_helm_chart"></a> [keycloak\_helm\_chart](#input\_keycloak\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_keycloak_helm_chart_version"></a> [keycloak\_helm\_chart\_version](#input\_keycloak\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_keycloak_helm_repo"></a> [keycloak\_helm\_repo](#input\_keycloak\_helm\_repo) | n/a | `string` | n/a | yes |
| <a name="input_keycloak_ingress_hostname"></a> [keycloak\_ingress\_hostname](#input\_keycloak\_ingress\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_keycloak_postgres_user"></a> [keycloak\_postgres\_user](#input\_keycloak\_postgres\_user) | n/a | `string` | n/a | yes |
| <a name="input_kubernetes_cluster_admin_activate"></a> [kubernetes\_cluster\_admin\_activate](#input\_kubernetes\_cluster\_admin\_activate) | n/a | `bool` | n/a | yes |
| <a name="input_kubernetes_resource_group"></a> [kubernetes\_resource\_group](#input\_kubernetes\_resource\_group) | n/a | `string` | n/a | yes |
| <a name="input_loki_deploy"></a> [loki\_deploy](#input\_loki\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_loki_helm_chart"></a> [loki\_helm\_chart](#input\_loki\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_loki_helm_chart_version"></a> [loki\_helm\_chart\_version](#input\_loki\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_loki_helm_repo_url"></a> [loki\_helm\_repo\_url](#input\_loki\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_loki_max_entries_limet_per_query"></a> [loki\_max\_entries\_limet\_per\_query](#input\_loki\_max\_entries\_limet\_per\_query) | n/a | `number` | n/a | yes |
| <a name="input_loki_persistence_memory"></a> [loki\_persistence\_memory](#input\_loki\_persistence\_memory) | n/a | `string` | n/a | yes |
| <a name="input_loki_provisioner"></a> [loki\_provisioner](#input\_loki\_provisioner) | Value for the provisioner key in the storage class. If in a bare metal environment and no provisioner available, set this to 'local-path' | `string` | n/a | yes |
| <a name="input_loki_release_name"></a> [loki\_release\_name](#input\_loki\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_loki_resources"></a> [loki\_resources](#input\_loki\_resources) | Values for the persistent volume and persistent volume claims when in <br>  a bare metal context and provisioner is set to local-path.<br>  If a provisioner is available, set the provisioner variable to the <br>  value of the StorageClass for this provisioner. | <pre>list(object({<br>    name         = string<br>    storage      = string<br>    labels       = map(string)<br>    access_modes = list(string)<br>    path         = string<br>  }))</pre> | n/a | yes |
| <a name="input_loki_retention_period"></a> [loki\_retention\_period](#input\_loki\_retention\_period) | n/a | `string` | n/a | yes |
| <a name="input_monitoring_namespace"></a> [monitoring\_namespace](#input\_monitoring\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_nginx_deploy"></a> [nginx\_deploy](#input\_nginx\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_nginx_helm_release_name"></a> [nginx\_helm\_release\_name](#input\_nginx\_helm\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_nginx_helm_repo_url"></a> [nginx\_helm\_repo\_url](#input\_nginx\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_nginx_ingress_version"></a> [nginx\_ingress\_version](#input\_nginx\_ingress\_version) | n/a | `string` | n/a | yes |
| <a name="input_nginx_namespace"></a> [nginx\_namespace](#input\_nginx\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_postgres_helm_chart"></a> [postgres\_helm\_chart](#input\_postgres\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_postgres_helm_chart_version"></a> [postgres\_helm\_chart\_version](#input\_postgres\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_postgres_helm_repo"></a> [postgres\_helm\_repo](#input\_postgres\_helm\_repo) | n/a | `string` | n/a | yes |
| <a name="input_project_customer_name"></a> [project\_customer\_name](#input\_project\_customer\_name) | n/a | `string` | n/a | yes |
| <a name="input_prom_admin_password"></a> [prom\_admin\_password](#input\_prom\_admin\_password) | n/a | `string` | n/a | yes |
| <a name="input_prom_cpu_mem_limits"></a> [prom\_cpu\_mem\_limits](#input\_prom\_cpu\_mem\_limits) | n/a | `string` | n/a | yes |
| <a name="input_prom_cpu_mem_request"></a> [prom\_cpu\_mem\_request](#input\_prom\_cpu\_mem\_request) | n/a | `string` | n/a | yes |
| <a name="input_prom_helm_chart"></a> [prom\_helm\_chart](#input\_prom\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_prom_helm_release_name"></a> [prom\_helm\_release\_name](#input\_prom\_helm\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_prom_helm_repo_url"></a> [prom\_helm\_repo\_url](#input\_prom\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_prom_redis_host_namespace"></a> [prom\_redis\_host\_namespace](#input\_prom\_redis\_host\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_prom_redis_port"></a> [prom\_redis\_port](#input\_prom\_redis\_port) | n/a | `number` | n/a | yes |
| <a name="input_prom_replicas_number"></a> [prom\_replicas\_number](#input\_prom\_replicas\_number) | n/a | `string` | n/a | yes |
| <a name="input_prom_retention"></a> [prom\_retention](#input\_prom\_retention) | n/a | `string` | n/a | yes |
| <a name="input_prom_stack_version"></a> [prom\_stack\_version](#input\_prom\_stack\_version) | n/a | `string` | n/a | yes |
| <a name="input_prom_storage_class_name"></a> [prom\_storage\_class\_name](#input\_prom\_storage\_class\_name) | n/a | `string` | n/a | yes |
| <a name="input_prom_storage_resource_request"></a> [prom\_storage\_resource\_request](#input\_prom\_storage\_resource\_request) | n/a | `string` | n/a | yes |
| <a name="input_prometheus_stack_deploy"></a> [prometheus\_stack\_deploy](#input\_prometheus\_stack\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_publicip_address"></a> [publicip\_address](#input\_publicip\_address) | n/a | `string` | n/a | yes |
| <a name="input_publicip_resource_group"></a> [publicip\_resource\_group](#input\_publicip\_resource\_group) | n/a | `string` | n/a | yes |
| <a name="input_redis_admin_password"></a> [redis\_admin\_password](#input\_redis\_admin\_password) | n/a | `string` | n/a | yes |
| <a name="input_storageclass_azure_deploy"></a> [storageclass\_azure\_deploy](#input\_storageclass\_azure\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_storageclass_bare_deploy"></a> [storageclass\_bare\_deploy](#input\_storageclass\_bare\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_storageclass_provisioner_azure"></a> [storageclass\_provisioner\_azure](#input\_storageclass\_provisioner\_azure) | n/a | `string` | n/a | yes |
| <a name="input_storageclass_provisioner_bare"></a> [storageclass\_provisioner\_bare](#input\_storageclass\_provisioner\_bare) | n/a | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | n/a | yes |
| <a name="input_tekton_deploy"></a> [tekton\_deploy](#input\_tekton\_deploy) | n/a | `string` | n/a | yes |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | n/a | yes |
| <a name="input_tf_access_key"></a> [tf\_access\_key](#input\_tf\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_tf_access_key_dns"></a> [tf\_access\_key\_dns](#input\_tf\_access\_key\_dns) | n/a | `string` | n/a | yes |
| <a name="input_tf_blob_name"></a> [tf\_blob\_name](#input\_tf\_blob\_name) | n/a | `string` | n/a | yes |
| <a name="input_tf_blob_name_core_dns"></a> [tf\_blob\_name\_core\_dns](#input\_tf\_blob\_name\_core\_dns) | n/a | `string` | n/a | yes |
| <a name="input_tf_blob_name_core_infra"></a> [tf\_blob\_name\_core\_infra](#input\_tf\_blob\_name\_core\_infra) | n/a | `string` | n/a | yes |
| <a name="input_tf_blob_name_core_ip"></a> [tf\_blob\_name\_core\_ip](#input\_tf\_blob\_name\_core\_ip) | n/a | `string` | n/a | yes |
| <a name="input_tf_container_name"></a> [tf\_container\_name](#input\_tf\_container\_name) | n/a | `string` | n/a | yes |
| <a name="input_tf_container_name_dns"></a> [tf\_container\_name\_dns](#input\_tf\_container\_name\_dns) | n/a | `string` | n/a | yes |
| <a name="input_tf_resource_group_name"></a> [tf\_resource\_group\_name](#input\_tf\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tf_resource_group_name_dns"></a> [tf\_resource\_group\_name\_dns](#input\_tf\_resource\_group\_name\_dns) | n/a | `string` | n/a | yes |
| <a name="input_tf_storage_account_name"></a> [tf\_storage\_account\_name](#input\_tf\_storage\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_tf_storage_account_name_dns"></a> [tf\_storage\_account\_name\_dns](#input\_tf\_storage\_account\_name\_dns) | n/a | `string` | n/a | yes |
| <a name="input_tls_certificate_type"></a> [tls\_certificate\_type](#input\_tls\_certificate\_type) | n/a | `string` | n/a | yes |
| <a name="input_tls_secret_name"></a> [tls\_secret\_name](#input\_tls\_secret\_name) | n/a | `string` | n/a | yes |
| <a name="input_vault_deploy"></a> [vault\_deploy](#input\_vault\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_vault_helm_chart"></a> [vault\_helm\_chart](#input\_vault\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_vault_helm_chart_version"></a> [vault\_helm\_chart\_version](#input\_vault\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_vault_helm_release_name"></a> [vault\_helm\_release\_name](#input\_vault\_helm\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_vault_helm_repo_url"></a> [vault\_helm\_repo\_url](#input\_vault\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_vault_ingress_enabled"></a> [vault\_ingress\_enabled](#input\_vault\_ingress\_enabled) | n/a | `bool` | n/a | yes |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_vault_replicas"></a> [vault\_replicas](#input\_vault\_replicas) | n/a | `number` | n/a | yes |
| <a name="input_vault_secret_name"></a> [vault\_secret\_name](#input\_vault\_secret\_name) | n/a | `string` | n/a | yes |
| <a name="input_vault_secrets_operator_deploy"></a> [vault\_secrets\_operator\_deploy](#input\_vault\_secrets\_operator\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_vault_secrets_operator_helm_chart"></a> [vault\_secrets\_operator\_helm\_chart](#input\_vault\_secrets\_operator\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_vault_secrets_operator_helm_chart_version"></a> [vault\_secrets\_operator\_helm\_chart\_version](#input\_vault\_secrets\_operator\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_vault_secrets_operator_helm_release_name"></a> [vault\_secrets\_operator\_helm\_release\_name](#input\_vault\_secrets\_operator\_helm\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_vault_secrets_operator_helm_repo_url"></a> [vault\_secrets\_operator\_helm\_repo\_url](#input\_vault\_secrets\_operator\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_vault_secrets_operator_namespace"></a> [vault\_secrets\_operator\_namespace](#input\_vault\_secrets\_operator\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_vault_secrets_operator_replicas"></a> [vault\_secrets\_operator\_replicas](#input\_vault\_secrets\_operator\_replicas) | n/a | `number` | n/a | yes |
| <a name="input_vault_secrets_operator_vault_address"></a> [vault\_secrets\_operator\_vault\_address](#input\_vault\_secrets\_operator\_vault\_address) | n/a | `string` | n/a | yes |
| <a name="input_velero_azure_subcription_id"></a> [velero\_azure\_subcription\_id](#input\_velero\_azure\_subcription\_id) | n/a | `string` | n/a | yes |
| <a name="input_velero_azure_tenant_id"></a> [velero\_azure\_tenant\_id](#input\_velero\_azure\_tenant\_id) | n/a | `string` | n/a | yes |
| <a name="input_velero_backup_client_id"></a> [velero\_backup\_client\_id](#input\_velero\_backup\_client\_id) | n/a | `string` | n/a | yes |
| <a name="input_velero_backup_client_secret"></a> [velero\_backup\_client\_secret](#input\_velero\_backup\_client\_secret) | n/a | `string` | n/a | yes |
| <a name="input_velero_backup_resource_group_cluster"></a> [velero\_backup\_resource\_group\_cluster](#input\_velero\_backup\_resource\_group\_cluster) | n/a | `string` | n/a | yes |
| <a name="input_velero_blob_storage_name"></a> [velero\_blob\_storage\_name](#input\_velero\_blob\_storage\_name) | n/a | `string` | n/a | yes |
| <a name="input_velero_bucket_name"></a> [velero\_bucket\_name](#input\_velero\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_velero_cloud_provider"></a> [velero\_cloud\_provider](#input\_velero\_cloud\_provider) | n/a | `string` | n/a | yes |
| <a name="input_velero_deploy"></a> [velero\_deploy](#input\_velero\_deploy) | n/a | `bool` | n/a | yes |
| <a name="input_velero_helm_chart"></a> [velero\_helm\_chart](#input\_velero\_helm\_chart) | n/a | `string` | n/a | yes |
| <a name="input_velero_helm_chart_version"></a> [velero\_helm\_chart\_version](#input\_velero\_helm\_chart\_version) | n/a | `string` | n/a | yes |
| <a name="input_velero_helm_repo_url"></a> [velero\_helm\_repo\_url](#input\_velero\_helm\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_velero_init_container_image"></a> [velero\_init\_container\_image](#input\_velero\_init\_container\_image) | n/a | `string` | n/a | yes |
| <a name="input_velero_namespace"></a> [velero\_namespace](#input\_velero\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_velero_release_name"></a> [velero\_release\_name](#input\_velero\_release\_name) | n/a | `string` | n/a | yes |
| <a name="input_velero_storage_account_access_key"></a> [velero\_storage\_account\_access\_key](#input\_velero\_storage\_account\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_velero_storage_account_name"></a> [velero\_storage\_account\_name](#input\_velero\_storage\_account\_name) | n/a | `string` | n/a | yes |
| <a name="input_velero_storage_account_resource_name"></a> [velero\_storage\_account\_resource\_name](#input\_velero\_storage\_account\_resource\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rendered"></a> [rendered](#output\_rendered) | n/a |
<!-- END_TF_DOCS -->
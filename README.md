<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.9 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 2.0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cert-manager"></a> [cert-manager](#module\_cert-manager) | ./create-cert-manager | n/a |
| <a name="module_create-ingress-nginx"></a> [create-ingress-nginx](#module\_create-ingress-nginx) | ./create-ingress-nginx | n/a |
| <a name="module_create-prometheus-stack"></a> [create-prometheus-stack](#module\_create-prometheus-stack) | ./create-prometheus-stack | n/a |
| <a name="module_loki"></a> [loki](#module\_loki) | ./create-loki | n/a |

## Resources

| Name | Type |
|------|------|
| [random_password.prom_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.redis_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_dns_name"></a> [api\_dns\_name](#input\_api\_dns\_name) | n/a | `string` | n/a | yes |
| <a name="input_certificate_cert_content"></a> [certificate\_cert\_content](#input\_certificate\_cert\_content) | n/a | `any` | n/a | yes |
| <a name="input_certificate_key_content"></a> [certificate\_key\_content](#input\_certificate\_key\_content) | n/a | `any` | n/a | yes |
| <a name="input_cluster_issuer_email"></a> [cluster\_issuer\_email](#input\_cluster\_issuer\_email) | Common environment variables | `string` | n/a | yes |
| <a name="input_grafana_loki_compatibility_image_tag"></a> [grafana\_loki\_compatibility\_image\_tag](#input\_grafana\_loki\_compatibility\_image\_tag) | n/a | `string` | n/a | yes |
| <a name="input_kube_config"></a> [kube\_config](#input\_kube\_config) | n/a | `any` | n/a | yes |
| <a name="input_loadbalancer_ip"></a> [loadbalancer\_ip](#input\_loadbalancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | n/a | `string` | n/a | yes |
| <a name="input_prom_cpu_mem_limits"></a> [prom\_cpu\_mem\_limits](#input\_prom\_cpu\_mem\_limits) | n/a | `string` | n/a | yes |
| <a name="input_prom_cpu_mem_request"></a> [prom\_cpu\_mem\_request](#input\_prom\_cpu\_mem\_request) | n/a | `string` | n/a | yes |
| <a name="input_publicip_resource_group"></a> [publicip\_resource\_group](#input\_publicip\_resource\_group) | n/a | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | `string` | n/a | yes |
| <a name="input_cluster_issuer_name"></a> [cluster\_issuer\_name](#input\_cluster\_issuer\_name) | n/a | `string` | `"letsencrypt-prod"` | no |
| <a name="input_create_prometheus_stack"></a> [create\_prometheus\_stack](#input\_create\_prometheus\_stack) | n/a | `bool` | `true` | no |
| <a name="input_helm_chart"></a> [helm\_chart](#input\_helm\_chart) | n/a | `string` | `"loki-stack"` | no |
| <a name="input_helm_repo_url"></a> [helm\_repo\_url](#input\_helm\_repo\_url) | n/a | `string` | `"https://grafana.github.io/helm-charts"` | no |
| <a name="input_ingress_nginx_version"></a> [ingress\_nginx\_version](#input\_ingress\_nginx\_version) | n/a | `string` | `"4.2.5"` | no |
| <a name="input_is_bare_metal"></a> [is\_bare\_metal](#input\_is\_bare\_metal) | n/a | `bool` | `false` | no |
| <a name="input_loki_max_entries_limet_per_query"></a> [loki\_max\_entries\_limet\_per\_query](#input\_loki\_max\_entries\_limet\_per\_query) | n/a | `number` | `50000` | no |
| <a name="input_loki_persistence_memory"></a> [loki\_persistence\_memory](#input\_loki\_persistence\_memory) | n/a | `string` | `"4Gi"` | no |
| <a name="input_loki_release_name"></a> [loki\_release\_name](#input\_loki\_release\_name) | n/a | `string` | `"loki"` | no |
| <a name="input_loki_retention_period"></a> [loki\_retention\_period](#input\_loki\_retention\_period) | n/a | `string` | `"720h"` | no |
| <a name="input_monitoring_namespace"></a> [monitoring\_namespace](#input\_monitoring\_namespace) | n/a | `string` | `"cosmotech-monitoring"` | no |
| <a name="input_provisioner"></a> [provisioner](#input\_provisioner) | Value for the provisioner key in the storage class. If in a bare metal environment and no provisioner available, set this to 'local-path' | `string` | `""` | no |
| <a name="input_resources"></a> [resources](#input\_resources) | Values for the persistent volume and persistent volume claims when in <br>  a bare metal context and provisioner is set to local-path.<br>  If a provisioner is available, set the provisioner variable to the <br>  value of the StorageClass for this provisioner. | <pre>list(object({<br>    name         = string<br>    storage      = string<br>    labels       = map(string)<br>    access_modes = list(string)<br>    path         = string<br>  }))</pre> | <pre>[<br>  {<br>    "access_modes": [<br>      "ReadWriteOnce"<br>    ],<br>    "labels": {<br>      "cosmotech.com/db": "loki"<br>    },<br>    "name": "loki",<br>    "path": "/mnt/loki-storage",<br>    "storage": "8Gi"<br>  },<br>  {<br>    "access_modes": [<br>      "ReadWriteOnce"<br>    ],<br>    "labels": {<br>      "cosmotech.com/db": "grafana"<br>    },<br>    "name": "grafana",<br>    "path": "/mnt/grafana-storage",<br>    "storage": "8Gi"<br>  }<br>]</pre> | no |
| <a name="input_tls_certificate_type"></a> [tls\_certificate\_type](#input\_tls\_certificate\_type) | n/a | `string` | `"let_s_encrypt"` | no |
| <a name="input_tls_secret_name"></a> [tls\_secret\_name](#input\_tls\_secret\_name) | n/a | `string` | `"letsencrypt-prod"` | no |
<!-- END_TF_DOCS -->
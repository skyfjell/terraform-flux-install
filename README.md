MOVED TO OMNITEQ

<!--- start terraform-docs --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | >= 0.1.6 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.10.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.4.1, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_flux"></a> [flux](#provider\_flux) | >= 0.1.6 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.10.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.4.1, < 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [flux_install.this](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/data-sources/install) | data source |
| [kubectl_file_documents.this](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether or not to create the namespace | `bool` | `true` | no |
| <a name="input_flux_version"></a> [flux\_version](#input\_flux\_version) | Flux version | `string` | `"v0.15.2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the cluster | `string` | `"default"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install in, and create(if enabled) | `string` | `"flux-system"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Install flux with network policy | `bool` | `false` | no |
| <a name="input_path_prefix"></a> [path\_prefix](#input\_path\_prefix) | Prefix to prepend to each path | `string` | `""` | no |
| <a name="input_paths"></a> [paths](#input\_paths) | Git repository path to the sync manifests | `list(string)` | <pre>[<br>  "/1f53734d-5e8d-4561-b9f2-b409499d098a/08cb5802-f420-4366-b7ea-ed1a5aa5307e"<br>]</pre> | no |
| <a name="input_toleration_keys"></a> [toleration\_keys](#input\_toleration\_keys) | Toleration keys for the flux components | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace flux was installed to |

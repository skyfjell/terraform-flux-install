# terraform-flux-install

## terraform-docs usage

`sed -i '' '/^<!--- start terraform-docs --->/q' README.md && terraform-docs md . >> README.md`

<!--- start terraform-docs --->

## Requirements

| Name                                                                        | Version |
| --------------------------------------------------------------------------- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)    | >= 0.15 |
| <a name="requirement_flux"></a> [flux](#requirement_flux)                   | 0.1.3   |
| <a name="requirement_kubectl"></a> [kubectl](#requirement_kubectl)          | 1.10.0  |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement_kubernetes) | 2.1.0   |

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_flux"></a> [flux](#provider_flux)                   | 0.1.3   |
| <a name="provider_kubectl"></a> [kubectl](#provider_kubectl)          | 1.10.0  |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | 2.1.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                               | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [kubectl_manifest.flux-install](https://registry.terraform.io/providers/gavinbunney/kubectl/1.10.0/docs/resources/manifest)        | resource    |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/2.1.0/docs/resources/namespace)           | resource    |
| [flux_install.this](https://registry.terraform.io/providers/fluxcd/flux/0.1.3/docs/data-sources/install)                           | data source |
| [kubectl_file_documents.this](https://registry.terraform.io/providers/gavinbunney/kubectl/1.10.0/docs/data-sources/file_documents) | data source |

## Inputs

| Name                                                                              | Description                                     | Type      | Default         | Required |
| --------------------------------------------------------------------------------- | ----------------------------------------------- | --------- | --------------- | :------: |
| <a name="input_create_namespace"></a> [create_namespace](#input_create_namespace) | value                                           | `boolean` | `true`          |    no    |
| <a name="input_name"></a> [name](#input_name)                                     | Name of the cluster                             | `string`  | n/a             |   yes    |
| <a name="input_namespace"></a> [namespace](#input_namespace)                      | Namespace to install in, and create(if enabled) | `string`  | `"flux-system"` |    no    |

## Outputs

| Name                                                                 | Description                                          |
| -------------------------------------------------------------------- | ---------------------------------------------------- |
| <a name="output_namespace"></a> [namespace](#output_namespace)       | The namespace flux was installed to                  |
| <a name="output_target_path"></a> [target_path](#output_target_path) | The local repository path for any flux configuration |

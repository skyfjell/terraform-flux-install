# Terraform Flux Install Module

This Terraform Module makes use of the `flux`, `kubernetes`, and `kubectl` providers to install `fluxcd` to a Kubernetes cluster, while exposing further configuration. Manifests are sourced from the official `flux` provider, so updating is typically as simple as bumping the `flux_version` input on this module.

All issues should be reported in the [GitHub repository](https://github.com/Skyfjall/terraform-flux-install/issues)

It is recommended to create `fluxcd` Custom Resource objects using the complementary Custom Resource modules, linked below.

A typical workflow with these modules is to install `flux`, configure the initial `GitRepository` and `flux` `Kustomization` resources with the additional modules, then continue cluster configuration from that `Kustomization` repository. Though you may use these modules to manage your clusters `flux` configuration entirely from Terraform, or mix and match.

## But there's already a `flux` provider?

This module resolves some consistency issues with out of spec properties in the flux manifests when appying via the `kubernetes` provider. It also performs the complete installation of the manifests. We do use the `flux` provider to pull manifests.

## Features

- Applies manifests with the official `kubernetes` providers' `kubernetes_manifest` resource
- Exposes deployment/pod resource configuration
- Fine control of installing CRDs and controller manifests

## Usage

For usage, see the examples:

- On the Terraform Registry, use the Examples dropdown near the top of the page
- In GitHub, navigate to the [Examples](examples/) directory

## Additional Flux Module Resources

The below modules provide support for individual configuration of `fluxcd` Custom Resources:

[Flux GitRepository Module](https://registry.terraform.io/modules/Skyfjall/git-repository/flux/latest)

[Flux Kustomization Module](https://registry.terraform.io/modules/Skyfjall/kustomization/flux/latest)

[Flux HelmRepository Module](https://registry.terraform.io/modules/Skyfjall/helm-repository/flux/latest)

[Flux HelmRelease Module](https://registry.terraform.io/modules/Skyfjall/helm-release/flux/latest)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                        | Version           |
| --------------------------------------------------------------------------- | ----------------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform)    | >= 1              |
| <a name="requirement_flux"></a> [flux](#requirement_flux)                   | >= 0.14.1         |
| <a name="requirement_kubectl"></a> [kubectl](#requirement_kubectl)          | >= 1.14.0         |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement_kubernetes) | >= 2.4.1, < 3.0.0 |

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_flux"></a> [flux](#provider_flux)                   | 0.14.1  |
| <a name="provider_kubectl"></a> [kubectl](#provider_kubectl)          | 1.14.0  |
| <a name="provider_kubernetes"></a> [kubernetes](#provider_kubernetes) | 2.11.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                               | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [kubernetes_manifest.controllers](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)     | resource    |
| [kubernetes_manifest.crds](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest)            | resource    |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)          | resource    |
| [flux_install.this](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/data-sources/install)                          | data source |
| [kubectl_file_documents.this](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name                                                                                       | Description                                     | Type                                                                                                                                                                                                                                | Default           | Required |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | :------: |
| <a name="input_cluster_domain"></a> [cluster_domain](#input_cluster_domain)                | Cluster Domain                                  | `string`                                                                                                                                                                                                                            | `"cluster.local"` |    no    |
| <a name="input_create_namespace"></a> [create_namespace](#input_create_namespace)          | Create Namespace?                               | `bool`                                                                                                                                                                                                                              | `true`            |    no    |
| <a name="input_flux_version"></a> [flux_version](#input_flux_version)                      | Flux version                                    | `string`                                                                                                                                                                                                                            | `"v0.30.2"`       |    no    |
| <a name="input_install_controllers"></a> [install_controllers](#input_install_controllers) | Install Controllers?                            | `bool`                                                                                                                                                                                                                              | `true`            |    no    |
| <a name="input_install_crds"></a> [install_crds](#input_install_crds)                      | Install CRDs?                                   | `bool`                                                                                                                                                                                                                              | `true`            |    no    |
| <a name="input_labels"></a> [labels](#input_labels)                                        | ID string and tags                              | <pre>object(<br> {<br> id = optional(string)<br> tags = optional(object({}))<br> }<br> )</pre>                                                                                                                                      | `{}`              |    no    |
| <a name="input_name"></a> [name](#input_name)                                              | Name of the cluster                             | `string`                                                                                                                                                                                                                            | `"default"`       |    no    |
| <a name="input_namespace"></a> [namespace](#input_namespace)                               | Namespace to install in, and create(if enabled) | `string`                                                                                                                                                                                                                            | `"flux-system"`   |    no    |
| <a name="input_network_policy"></a> [network_policy](#input_network_policy)                | Install flux with network policy                | `bool`                                                                                                                                                                                                                              | `true`            |    no    |
| <a name="input_resources"></a> [resources](#input_resources)                               | Deployment Pod Resources                        | <pre>map(object({<br> limits = optional(object({<br> cpu = optional(string)<br> memory = optional(string)<br> })),<br> requests = optional(object({<br> cpu = optional(string)<br> memory = optional(string)<br> })),<br> }))</pre> | `{}`              |    no    |
| <a name="input_tolerations"></a> [tolerations](#input_tolerations)                         | Toleration keys for the flux components         | `list(string)`                                                                                                                                                                                                                      | `[]`              |    no    |

## Outputs

| Name                                                           | Description                         |
| -------------------------------------------------------------- | ----------------------------------- |
| <a name="output_namespace"></a> [namespace](#output_namespace) | The namespace flux was installed to |

<!-- END_TF_DOCS -->

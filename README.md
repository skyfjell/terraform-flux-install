# Terraform Flux Install Module

This Terraform Module makes use of the `flux`, `kubernetes`, and `kubectl` providers to install `fluxcd` to a Kubernetes cluster, while exposing further configuration. Manifests are sourced from the official `flux` provider, so updating is typically as simple as bumping the `flux_version` input on this module.

All issues should be reported in the [GitHub repository](https://github.com/skyfjell/terraform-flux-install/issues)

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

[Flux GitRepository Module](https://registry.terraform.io/modules/skyfjell/git-repository/flux/latest)

[Flux Kustomization Module](https://registry.terraform.io/modules/skyfjell/kustomization/flux/latest)

[Flux HelmRepository Module](https://registry.terraform.io/modules/skyfjell/helm-repository/flux/latest)

[Flux HelmRelease Module](https://registry.terraform.io/modules/skyfjell/helm-release/flux/latest)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.2.0, < 3.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.4.1, < 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.6.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Flux Chart Version | `string` | `"1.3.0"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create Namespace? | `bool` | `true` | no |
| <a name="input_install_controllers"></a> [install\_controllers](#input\_install\_controllers) | Install Controllers? | `bool` | `true` | no |
| <a name="input_install_crds"></a> [install\_crds](#input\_install\_crds) | Install CRDs? | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | ID string and tags | <pre>object(<br>    {<br>      id   = optional(string)<br>      tags = optional(object({}))<br>    }<br>  )</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Cluster Name | `string` | `"default"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to Install/Create | `string` | `"flux-system"` | no |
| <a name="input_node_selector"></a> [node\_selector](#input\_node\_selector) | Node Selector for Components | `map(string)` | `{}` | no |
| <a name="input_specs"></a> [specs](#input\_specs) | Deployment Pod Specs | <pre>map(object({<br>    resources = object({<br>      limits   = optional(map(string)),<br>      requests = optional(map(string)),<br>    }),<br>    nodeSelector = optional(map(string))<br>  }))</pre> | `{}` | no |
| <a name="input_tolerations"></a> [tolerations](#input\_tolerations) | Toleration Keys for Components | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | The namespace flux was installed to |
<!-- END_TF_DOCS -->

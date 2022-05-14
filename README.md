# Terraform Flux Install Module

This Terraform Module makes use of the `flux`, `kubernetes`, and `kubectl` providers to install `fluxcd` to a Kubernetes cluster, while exposing further configuration. Manifests are sourced from the official `flux` provider, so updating is typically as simple as bumping the `flux_version` input on this module.

All issues should be reported in the [GitHub repository](https://github.com/OmniTeqSource/terraform-flux-install/issues)

It is recommended to create `fluxcd` Custom Resource objects using the complementary Custom Resource modules, linked below.

## But there's already a `flux` provider?

This module resolves some consistency issues with out of spec properties in the flux manifests when appying via the `kubernetes` provider. It also performs the complete installation of the manifests.

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

[Flux GitRepository Module](https://registry.terraform.io/modules/OmniTeqSource/git-repository/flux/latest)

[Flux Kustomization Module](https://registry.terraform.io/modules/OmniTeqSource/kustomization/flux/latest)

[Flux HelmRepository Module](https://registry.terraform.io/modules/OmniTeqSource/helm-repository/flux/latest)

[Flux HelmRelease Module](https://registry.terraform.io/modules/OmniTeqSource/helm-release/flux/latest)

<!-- BEGIN_TF_DOCS -->

{{ .Content }}

<!-- END_TF_DOCS -->

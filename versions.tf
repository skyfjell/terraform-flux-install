terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.14.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1, < 3.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }

  required_version = ">= 1"

  experiments = [module_variable_optional_attrs]
}

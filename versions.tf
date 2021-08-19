terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.1.6"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1, < 3.0.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }

  required_version = ">= 0.15"
}

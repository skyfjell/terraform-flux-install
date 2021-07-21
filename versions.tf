terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.1.6"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.1.0"
    }
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = ">= 0.4.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.10.0"
    }
  }

  required_version = ">= 0.15"
}

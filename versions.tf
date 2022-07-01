terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.2.0, < 3.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.4.1, < 3.0.0"
    }
  }

  required_version = ">= 1"

  experiments = [module_variable_optional_attrs]
}

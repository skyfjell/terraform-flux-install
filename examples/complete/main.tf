provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-tftest"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "k3d-tftest"
  }
}

module "flux-install-complete" {
  source = "../../"

  # Required Variables
  # None

  # Optional Variables
  create_namespace    = true
  install_crds        = true
  install_controllers = true
  namespace           = "flux-system"
  network_policy      = true
  flux_version        = "v0.30.2"
  cluster_domain      = "cluster.local"

  tolerations = [
    {
      key      = "delivery"
      operator = "Exists"
      effect   = "NoSchedule"
    }
  ]

  node_selector = {
    "kubernetes.io/os" = "linux"
  }

  specs = {
    source-controller = {
      resources = {
        limits = {
          memory = "2Gi"
        },
        requests = {
          memory = "1Gi"
        }
      }
    }
  }
}

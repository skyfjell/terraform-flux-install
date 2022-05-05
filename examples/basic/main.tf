provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-tftest"
  experiments {
    manifest_resource = true
  }
}

module "flux-install-basic" {
  source              = "../../"
  install_crds        = true
  install_controllers = true

  resources = {
    source-controller = {
      limits = {
        memory = "4Gi"
      },
      requests = {
        memory = "2Gi"
      }
    }
  }
}

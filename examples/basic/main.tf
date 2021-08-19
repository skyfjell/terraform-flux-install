provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-tftest"
  experiments {
    manifest_resource = true
  }
}

module "flux-install-basic" {
  source = "../../"
}

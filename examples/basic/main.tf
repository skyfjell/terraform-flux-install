provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-tftest"
}

provider "kubernetes-alpha" {
  config_path    = "~/.kube/config"
  config_context = "k3d-tftest"
}

module "flux-install-basic" {
  source = "../../"
}

locals {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  cluster_domain   = var.cluster_domain
  tolerations      = var.tolerations
  network_policy   = var.network_policy
  version          = var.flux_version

  install_crds        = var.install_crds
  install_controllers = var.install_controllers

  resources = {
    for name, types in var.resources : name => {
      for type, resources in types : type => {
        for resource, value in resources : resource => value if value != null
      }
    }
  }

  labels = var.labels
}

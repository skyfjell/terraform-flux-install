locals {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  cluster_domain   = var.cluster_domain
  tolerations      = var.tolerations
  node_selector    = var.node_selector
  network_policy   = var.network_policy
  version          = var.flux_version

  install_crds        = var.install_crds
  install_controllers = var.install_controllers

  specs = merge(
    var.specs,
    {
      "helm-controller"             = {},
      "image-automation-controller" = {},
      "image-reflector-controller"  = {},
      "kustomize-controller"        = {},
      "notification-controller"     = {},
      "source-controller"           = {},
    }
  )

  labels = var.labels
}

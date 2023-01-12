locals {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  tolerations      = var.tolerations
  node_selector    = var.node_selector
  chart_version    = var.chart_version

  install_crds        = var.install_crds
  install_controllers = var.install_controllers

  specs = merge(
    var.specs,
    {
      "cli"                       = {},
      "helmController"            = {},
      "imageAutomationController" = {},
      "imageReflectorController"  = {},
      "kustomizeController"       = {},
      "notificationController"    = {},
      "sourceController"          = {},
    }
  )

  labels = var.labels
}

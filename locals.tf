locals {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  path_prefix      = var.path_prefix
  toleration_keys  = var.toleration_keys
  network_policy   = var.network_policy
  version          = var.flux_version
  paths            = length(local.path_prefix) == 0 ? var.paths : formatlist("%s/%s", local.path_prefix, var.paths)
  paths_string     = join("\\,", local.paths)

  install_crds        = var.install_crds
  install_controllers = var.install_controllers

  resources = {
    for name, types in var.resources : name => {
      for type, resources in types : type => {
        for resource, value in resources : resource => value if value != null
      }
    }
  }
}

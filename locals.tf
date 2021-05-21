locals {
  name             = var.name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  path_prefix      = var.path_prefix
  toleration_keys  = var.toleration_keys
}

locals {
  # Add path prefix to all paths if exists.
  paths = length(local.path_prefix) == 0 ? var.paths : formatlist("%s/%s", local.path_prefix, var.paths)
}

locals {
  paths_string = join("\\,", local.paths)
}

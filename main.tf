resource "kubernetes_namespace" "this" {
  count = local.create_namespace ? 1 : 0
  metadata {
    name = local.namespace
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

data "flux_install" "this" {
  target_path    = local.paths_string
  network_policy = local.network_policy
  version        = local.version

  # TODO This should be required for the module.
  toleration_keys = local.toleration_keys
}

data "kubectl_file_documents" "this" {
  content = data.flux_install.this.content
}

resource "kubernetes_manifest" "flux-install" {
  provider = kubernetes-alpha

  for_each = data.kubectl_file_documents.this.documents

  manifest = yamldecode(each.value)

  depends_on = [kubernetes_namespace.this]
}

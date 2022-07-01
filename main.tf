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

  timeouts {
    delete = "30m"
  }
}

locals {
  main-tf = {
    values = merge(
      {
        for name, spec in local.specs : replace(name, "-", "") => merge(
          spec,
          {
            tolerations  = local.tolerations,
            nodeSelector = local.node_selector
            create       = local.install_controllers
          }
        )
      },
      {
        installCRDs = local.install_crds,
      }
    )
  }
}

resource "helm_release" "this" {
  name       = local.name
  repository = "https://fluxcd-community.github.io/helm-charts"
  chart      = "flux2"
  values     = [yamlencode(local.main-tf.values)]
  namespace  = local.namespace

  depends_on = [kubernetes_namespace.this]
}
